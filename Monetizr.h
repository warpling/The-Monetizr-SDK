//
//  Monetizr.h
//  v1.2.0
//  Created by Armands Avotins on 09/05/16.
//  Updated by Armands Avotins on 28/09/17.
//  Copyright © 2016 TheMonetizr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Buy/Buy.h>
#import <sys/utsname.h>
#import <AFNetworking/AFNetworking.h>
// @import UIKit;

#import "ProductListViewController.h"
#import "ProductViewController.h"
#import "Theme.h"
#import "ShippingRatesTableViewController.h"
#import "ProductViewControllerToggleTableViewCell.h"
#import "ProductViewControllerThemeStyleTableViewCell.h"
#import "ProductViewControllerThemeTintColorTableViewCell.h"

//#import "BUYTheme.h"
//#import "BUYProductViewController.h"

@interface Monetizr : UIViewController

@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, strong) BUYCollection *collection;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSOperation *collectionOperation;
@property (nonatomic, strong) NSOperation *checkoutCreationOperation;

@property (nonatomic, assign) BOOL demoProductViewController;
@property (nonatomic, assign) ThemeStyle themeStyle;
@property (nonatomic, strong) NSArray *themeTintColors;
@property (nonatomic, assign) NSInteger themeTintColorSelectedIndex;
@property (nonatomic, assign) BOOL showsProductImageBackground;
@property (nonatomic, assign) BOOL presentViewController;

+ (void) showProductWithID: (NSString *) productID;
+ (void) showProductForTag: (NSString *) productTag forUser: (NSString *) userID;
+ (void) showProductForTag: (NSString *) productTag;

@end
