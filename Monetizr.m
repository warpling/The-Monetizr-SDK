//
//  Monetizr.m
//  v1.1.0
//  Created by Armands Avotins on 09/05/16.
//  Copyright © 2016 TheMonetizr. All rights reserved.
//

#import "Monetizr.h"

@implementation Monetizr

+ (void) showProductForTag: (NSString *) productTag forUser: (NSString *) userID {
    // Start networking
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Monetizr" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *apiKey = [dict valueForKey:@"apiKey"];
    NSString *apiUrl = [dict valueForKey:@"apiUrl"];
    //NSDictionary *parameters = @{@"apikey": apiKey, @"tag": productTag, @"userID": userID};
    NSString *urlString = [NSString stringWithFormat:@"https://%@/get-tag?apiKey=%@&tag=%@&user_id=%@", apiUrl, apiKey, productTag, userID];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        // Success
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            // Valid response
            if (responseObject[@"is_active"]) {
                // Response have key active
                if ([[responseObject valueForKey:@"is_active"] boolValue]) {
                    // Tag is active
                    if (responseObject[@"product_id"]) {
                        // Got product ID
                        if (![[responseObject valueForKey:@"product_id"] isKindOfClass:[NSNull class]]) {
                            NSString *productID = [responseObject valueForKey:@"product_id"];
                            [self showProductWithID:productID];
                        }
                    }
                }
            }
        }

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        // Failure
        NSLog(@"Error: %@", error);
        //NSString* htmlString = [[NSString alloc] initWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];

    }];
}

+ (void) showProductWithID: (NSString *) productID {
    // Read Monetizr properties
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Monetizr" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *shopDomain = [dict valueForKey:@"shopDomain"];
    NSString *apiKey = [dict valueForKey:@"apiKey"];
    NSString *appId = [dict valueForKey:@"appId"];
    NSString *applePayMerchantId = [dict valueForKey:@"applePayMerchantId"];


    BUYClient *client = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:apiKey appId:appId];

    Theme *theme = [Theme new];
    theme.showsProductImageBackground = YES;

    // Determ product variant to choose by default
    NSString *deviceName = [Monetizr deviceName];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *productIDNumber = [formatter numberFromString:productID];

    [client getProductById:productIDNumber completion:^(BUYProduct *product, NSError *error) {
        if (error) {
            NSLog(@"Error retrieving product: %@", error.userInfo);
        } else {
            ProductViewController *productViewController = [[ProductViewController alloc] initWithClient:client theme:theme];

            [productViewController setMerchantId:applePayMerchantId];

            //[productViewController allowApplePaySetup];
            //[productViewController loadWithProduct:product completion:NULL];

            [productViewController loadWithProduct:product forDevice:deviceName completion:NULL];



            UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            while (topRootViewController.presentedViewController)
            {
                topRootViewController = topRootViewController.presentedViewController;
            }

            [topRootViewController presentViewController:productViewController animated:YES completion:nil];

        }
    }];
}

+ (NSString*) deviceName
{
    struct utsname systemInfo;

    uname(&systemInfo);

    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];

    static NSDictionary* deviceNamesByCode = nil;

    if (!deviceNamesByCode) {

        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",

                              // Models list
                              @"iPhone5,3"	:@"iPhone 5c",
                              @"iPhone5,4"	:@"iPhone 5c",
                              @"iPhone6,1"	:@"iPhone 5/5s/SE",
                              @"iPhone6,2"	:@"iPhone 5/5s/SE",
                              @"iPhone7,1"	:@"iPhone 6/6s Plus",
                              @"iPhone7,2"	:@"iPhone 6/6s",
                              @"iPhone8,1"	:@"iPhone 6/6s",
                              @"iPhone8,2"	:@"iPhone 6/6s Plus",
                              @"iPhone9,1"  :@"iPhone 7",
                              @"iPhone9,3"  :@"iPhone 7",
                              @"iPhone9,2"  :@"iPhone 7 Plus",
                              @"iPhone9,4"  :@"iPhone 7 Plus",
                              @"iPad1,1"	:@"iPad",
                              @"iPad2,1"	:@"iPad 2",
                              @"iPad2,2"	:@"iPad 2",
                              @"iPad2,3"	:@"iPad 2",
                              @"iPad2,4"	:@"iPad 2",
                              @"iPad2,5"	:@"iPad mini",
                              @"iPad2,6"	:@"iPad mini",
                              @"iPad2,7"	:@"iPad mini",
                              @"iPad3,1"	:@"iPad (3rd gen)",
                              @"iPad3,2"	:@"iPad (3rd gen)",
                              @"iPad3,3"	:@"iPad (3rd gen)",
                              @"iPad3,4"	:@"iPad (4th gen)",
                              @"iPad3,5"	:@"iPad (4th gen)",
                              @"iPad3,6"	:@"iPad (4th gen)",
                              @"iPad4,1"	:@"iPad Air",
                              @"iPad4,2"	:@"iPad Air",
                              @"iPad4,3"	:@"iPad Air",
                              @"iPad4,4"	:@"iPad mini 2",
                              @"iPad4,5"	:@"iPad mini 2",
                              @"iPad4,6"	:@"iPad mini 2",
                              @"iPad4,7"	:@"iPad mini 3",
                              @"iPad4,8"	:@"iPad mini 3",
                              @"iPad4,9"	:@"iPad mini 3",
                              @"iPad5,1"	:@"iPad mini 4",
                              @"iPad5,2"	:@"iPad mini 4",
                              @"iPad5,3"	:@"iPad Air 2",
                              @"iPad5,4"	:@"iPad Air 2",
                              @"iPad6,7"	:@"iPad Pro",
                              @"iPad6,8"	:@"iPad Pro",
                              @"iPod1,1"	:@"iPod touch",
                              @"iPod2,1"	:@"iPod touch (2nd gen)",
                              @"iPod3,1"	:@"iPod touch (3rd gen)",
                              @"iPod4,1"	:@"iPod touch (4th gen)",
                              @"iPod5,1"	:@"iPod touch (5th gen)",
                              @"iPod7,1"	:@"iPod touch (6th gen)"
                              };
    }

    NSString* deviceName = [deviceNamesByCode objectForKey:code];

    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:

        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"Unknown";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"Unknown";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"Unknown";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}

// Post statistics

@end
