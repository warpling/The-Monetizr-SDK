//
//  BUYAddress+Validation.m
//  
//
//  Created by Armands Avotins on 22/11/2017.
//

#import "BUYAddress+Validation.h"

@implementation BUYAddress (Validation)

#pragma mark - Method Swizzling
- (BOOL)isValidAddressForShippingRatesOverride
{
    BOOL valid = NO;
    if (self.city.length > 0 &&
        self.zip.length > 0 &&
        (self.country.length > 0 || self.countryCode.length == 2)) {
        
        valid = YES;
    }
    
    return valid;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL defaultSelector = @selector(isValidAddressForShippingRates);
        SEL swizzledSelector = @selector(isValidAddressForShippingRatesOverride);
        
        Method defaultMethod = class_getInstanceMethod(class, defaultSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL isMethodExists = !class_addMethod(class, defaultSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (isMethodExists) {
            method_exchangeImplementations(defaultMethod, swizzledMethod);
        }
        else {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
        }
    });
}

@end
