//
//  Monetizr.h
//  Created by Armands Avotins on 09/05/16.
//  Copyright © 2016 TheMonetizr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Buy/Buy.h>
#import <sys/utsname.h>
#import <AFNetworking/AFNetworking.h>

#import "ProductListViewController.h"
#import "ProductViewController.h"
#import "Theme.h"
#import "ShippingRatesTableViewController.h"
#import "ProductViewControllerToggleTableViewCell.h"
#import "ProductViewControllerThemeStyleTableViewCell.h"
#import "ProductViewControllerThemeTintColorTableViewCell.h"

@interface Monetizr : NSObject

+ (void) showProductWithID:(NSString *)productID;
+ (void) showProductWithID:(NSString *)productID completion:(void (^)(BOOL success, NSError *error))completion;

+ (void) showProductForTag: (NSString *)productTag forUser:(NSString *)userID;
+ (void) showProductForTag:(NSString *)productTag forUser:(NSString *)userID completion:(void (^)(BOOL success, NSError *error))completion;

+ (void) showProductForTag:(NSString *)productTag;
+ (void) showProductForTag:(NSString *)productTag completion:(void (^)(BOOL success, NSError *error))completion;

@end
