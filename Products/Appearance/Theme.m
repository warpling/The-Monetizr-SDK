//
//  Theme.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "DisclosureIndicatorView.h"
#import "ErrorView.h"
#import "NavigationController.h"
#import "OptionSelectionNavigationController.h"
#import "OptionValueCell.h"
#import "ProductDescriptionCell.h"
#import "ProductHeaderCell.h"
#import "ProductVariantCell.h"
#import "OptionBreadCrumbsView.h"
#import "HeaderOverlayView.h"
#import "ProductViewNavigationController.h"
#import "ProductViewController.h"
#import "ProductView.h"
#import "Theme.h"
#import "Theme+Additions.h"
#import "VariantOptionView.h"
#import "VisualEffectView.h"
#import "UIColor+Additions.h"
#import "CheckoutButton.h"

@implementation Theme

- (instancetype)init
{

    self = [super init];

    if (self) {
        self.style = ThemeStyleDark;
        self.tintColor = [UIColor rotationPrimary];
        self.showsProductImageBackground = YES;
        self.showsProductShareButton = NO;
    }

    return self;
}

- (void)styleProductViewController
{
    UIColor *contentBackgroundColor = self.style == ThemeStyleDark ? BUY_RGB(26, 26, 28) : [UIColor whiteColor];
    UIColor *contentBackgroundSelectedColor = self.style == ThemeStyleDark ? BUY_RGB(80, 80, 80) : BUY_RGB(242, 242, 242);
    UIColor *contentBackgroundComplimentaryColor = self.style == ThemeStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
    UIColor *contentTextColor = self.style == ThemeStyleDark ? [UIColor colorWithWhite:0.8 alpha:1] : [UIColor colorWithWhite:0.3 alpha:1];
    UIColor *primaryColor = self.tintColor;
    UIColor *secondaryLightColor = self.style == ThemeStyleDark ? BUY_RGB(14, 14, 14) : BUY_RGB(229, 229, 229);
    UIColor *secondaryMediumColor = self.style == ThemeStyleDark ? BUY_RGB(150, 150, 150) : BUY_RGB(217, 217, 217);
    UIColor *secondaryDarkColor = self.style == ThemeStyleDark ? BUY_RGB(175, 175, 175) : BUY_RGB(191, 191, 191);
    UIBarStyle barStyle = self.style == ThemeStyleDark ? UIBarStyleBlack : UIBarStyleDefault;
    UIColor *errorColor = self.style == ThemeStyleDark ? BUY_RGBA(255, 66, 66, 0.75f) : BUY_RGBA(209, 44, 44, 0.75f);
    UIBlurEffectStyle blurEffectStyle = self.style == ThemeStyleDark ? UIBlurEffectStyleDark : UIBlurEffectStyleLight;
    UIScrollViewIndicatorStyle scrollViewIndicatorStyle = self.style == ThemeStyleDark ? UIScrollViewIndicatorStyleWhite : UIScrollViewIndicatorStyleDefault;

	// Add some Theme-specific styling:
    UIColor *navigationBarTitleColor = self.style == ThemeStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
    UIColor *navigationBarTitleVariantSelectionColor = self.style == ThemeStyleDark ? BUY_RGB(229, 229, 229) : [UIColor blackColor];

    if ([[UINavigationBar class] respondsToSelector:@selector(appearanceWhenContainedInInstancesOfClasses:)]) {
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[ProductViewNavigationController class]]] setTitleTextAttributes:@{ NSForegroundColorAttributeName : navigationBarTitleVariantSelectionColor }];
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[OptionSelectionNavigationController class]]] setTitleTextAttributes:@{ NSForegroundColorAttributeName : navigationBarTitleVariantSelectionColor }];
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[NavigationController class]]] setTitleTextAttributes:@{ NSForegroundColorAttributeName : navigationBarTitleColor }];
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[NavigationController class]]] setTintColor:primaryColor];
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[NavigationController class]]] setBarStyle:barStyle];
        [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[NavigationController class]]] setBackgroundColor:contentBackgroundColor];
        [[UITableView appearanceWhenContainedInInstancesOfClasses:@[[NavigationController class]]] setSeparatorColor:secondaryMediumColor];
        [[UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[NavigationController class]]] setIndicatorStyle:scrollViewIndicatorStyle];
        [[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[ProductViewController class]]] setColor:primaryColor];
    } else {
        [[UINavigationBar appearanceWhenContainedIn:[OptionSelectionNavigationController class], nil] setTitleTextAttributes:@{ NSForegroundColorAttributeName : navigationBarTitleVariantSelectionColor }];
        [[UINavigationBar appearanceWhenContainedIn:[NavigationController class], nil] setTitleTextAttributes:@{ NSForegroundColorAttributeName : navigationBarTitleColor }];
        [[UINavigationBar appearanceWhenContainedIn:[NavigationController class], nil] setTintColor:primaryColor];
        [[UINavigationBar appearanceWhenContainedIn:[NavigationController class], nil] setBarStyle:barStyle];
        [[UITableView appearanceWhenContainedIn:[NavigationController class], nil] setBackgroundColor:contentBackgroundColor];
        [[UITableView appearanceWhenContainedIn:[NavigationController class], nil] setSeparatorColor:secondaryMediumColor];
        [[UIScrollView appearanceWhenContainedIn:[NavigationController class], nil] setIndicatorStyle:scrollViewIndicatorStyle];
        [[UIActivityIndicatorView appearanceWhenContainedIn:[ProductViewController class], nil] setColor:primaryColor];
    }
	
    [[ProductView appearance] setTintColor:primaryColor];
    [[ProductView appearance] setShowsProductImageBackground:self.showsProductImageBackground];
    [[VariantOptionView appearance] setOptionNameTextColor:secondaryDarkColor];
    [[VisualEffectView appearance] setBlurEffectStyle:blurEffectStyle];
    [[CheckoutButton appearance] setBackgroundColor:primaryColor];
    [[CheckoutButton appearance] setTextColor:contentBackgroundColor];
    [[DisclosureIndicatorView appearance] setTintColor:secondaryDarkColor];
    [[ErrorView appearance] setOverlayColor:errorColor];
    [[ProductView appearance] setBackgroundColor:contentBackgroundColor];
    [[ProductHeaderCell appearance] setProductTitleColor:contentBackgroundComplimentaryColor];
    [[ProductHeaderCell appearance] setBackgroundColor:contentBackgroundColor];
    [[ProductDescriptionCell appearance] setDescriptionTextColor:contentTextColor];
    [[ProductDescriptionCell appearance] setBackgroundColor:contentBackgroundColor];
    [[ProductVariantCell appearance] setBackgroundColor:contentBackgroundColor];
    [[ProductVariantCell appearance] setSelectedBackgroundViewBackgroundColor:contentBackgroundSelectedColor];
    [[VariantOptionView appearance] setBackgroundColor:contentBackgroundColor];
    [[OptionValueCell appearance] setTintColor:primaryColor];
    [[OptionValueCell appearance] setBackgroundColor:contentBackgroundColor];
    [[OptionValueCell appearance] setSelectedBackgroundViewBackgroundColor:contentBackgroundSelectedColor];
    [[HeaderOverlayView appearance] setOverlayBackgroundColor:contentBackgroundColor];
    [[OptionBreadCrumbsView appearance] setBackgroundColor:secondaryLightColor];
    [[OptionBreadCrumbsView appearance] setVariantOptionTextColor:BUY_RGB(140, 140, 140)];
}

@end
