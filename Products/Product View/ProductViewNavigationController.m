//
//  ProductViewNavigationController.m
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

#import "ProductViewNavigationController.h"
#import "ImageKit.h"
#import "Theme+Additions.h"
#import "ProductViewController.h"

@implementation ProductViewNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissPopover)];
    leftButton.accessibilityValue = NSLocalizedString(@"close", @"VoiceOver label for close button");
    self.topViewController.navigationItem.leftBarButtonItem = leftButton;
	
	return self;
}

- (void)dismissPopover
{
	if ([self.navigationDelegate respondsToSelector:@selector(presentationControllerWillDismiss:)]) {
		[self.navigationDelegate presentationControllerWillDismiss:nil];
	}
	[self dismissViewControllerAnimated:YES completion:^{
		if ([self.navigationDelegate respondsToSelector:@selector(presentationControllerDidDismiss:)]) {
			[self.navigationDelegate presentationControllerDidDismiss:nil];
		}
	}];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (BOOL)shouldAutorotate {
	return self.topViewController.shouldAutorotate;
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
	return [self childViewController];
}

-(UIViewController *)childViewControllerForStatusBarHidden
{
	return [self childViewController];
}

-(UIViewController*)childViewController
{
	if ([self.visibleViewController isKindOfClass:[ProductViewController class]] == NO) {
		return self.viewControllers[0];
	}
	return self.visibleViewController;
}

#pragma mark - Accessibility
- (BOOL) accessibilityPerformEscape {
    [self dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

@end
