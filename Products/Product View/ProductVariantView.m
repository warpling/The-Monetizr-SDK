//
//  ProductVariantView.m
//
//  Monetizr SDK
//
//  Created by Monetizr.
//  Copyright (c) 2017 Monetizr Inc. All rights reserved.
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

#import "ProductVariantView.h"

@implementation ProductVariantView

CGFloat const bWidth = 10.0f;

- (instancetype)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingVerySmall, self.layoutMargins.left, kBuyPaddingVerySmall, self.layoutMargins.right);
        
        _optionView1 = [[VariantOptionView alloc] init];
       _optionView1.translatesAutoresizingMaskIntoConstraints = NO;
        [_optionView1 setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:_optionView1];
        
        _optionView2 = [[VariantOptionView alloc] init];
       _optionView2.translatesAutoresizingMaskIntoConstraints = NO;
        [_optionView3 setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:_optionView2];
        
        _optionView3 = [[VariantOptionView alloc] init];
        _optionView3.translatesAutoresizingMaskIntoConstraints = NO;
        [_optionView3 setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:_optionView3];
        
        _disclosureIndicatorImageView = [[DisclosureIndicatorView alloc] init];
        _disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_disclosureIndicatorImageView];

        NSDictionary *views = NSDictionaryOfVariableBindings(_optionView1, _optionView2, _optionView3, _disclosureIndicatorImageView);
        
        NSDictionary *metricsDictionary = @{ @"paddingExtraLarge" : @(kBuyPaddingExtraLarge), @"paddingSmall" : @(kBuyPaddingSmall), @"buttonWidth" : @(bWidth), @"paddingNone" : @(kBuyPaddingNone), @"paddingVerySmall" :@(kBuyPaddingVerySmall) };
        
        self.constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_optionView1]-(paddingExtraLarge)-[_optionView2]-(paddingExtraLarge)-[_optionView3]-(>=paddingSmall)-[_disclosureIndicatorImageView(buttonWidth)]-|" options:0 metrics:metricsDictionary views:views];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(paddingSmall)-[_optionView1]-|" options:0 metrics:metricsDictionary views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(paddingSmall)-[_optionView2]-|" options:0 metrics:metricsDictionary views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(paddingSmall)-[_optionView3]-|" options:0 metrics:metricsDictionary views:views]];
        
        [self addConstraint: [NSLayoutConstraint constraintWithItem:_disclosureIndicatorImageView
                                                                      attribute:NSLayoutAttributeCenterY
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:_disclosureIndicatorImageView.superview
                                                                      attribute:NSLayoutAttributeCenterY
                                                                     multiplier:1.0f
                                                                       constant:0.0f]];
        [NSLayoutConstraint activateConstraints:self.constraints];
        
        self.accessibilityTraits |= UIAccessibilityTraitButton;
        self.accessibilityHint = NSLocalizedString(@"tap to change", @"VoiceOver hint for product variant cell");
    }
    return self;
}

- (void)setOptionsForProductVariant:(BUYProductVariant *)productVariant hideDisclosureIndicator:(BOOL)hide
{
    self.disclosureIndicatorImageView.hidden = hide;
    
    NSArray *productOptions = [productVariant.options allObjects];
    
    switch (productVariant.options.count) {
        case 3:
            [self.optionView3 setTextForOptionValue:productOptions[2]];
            [self.optionView2 setTextForOptionValue:productOptions[1]];
            [self.optionView1 setTextForOptionValue:productOptions[0]];
            break;
            
        case 2:
            [self.optionView3 setTextForOptionValue:nil];
            [self.optionView2 setTextForOptionValue:productOptions[1]];
            [self.optionView1 setTextForOptionValue:productOptions[0]];
            break;
            
        case 1:
            [self.optionView3 setTextForOptionValue:nil];
            [self.optionView2 setTextForOptionValue:nil];
            [self.optionView1 setTextForOptionValue:productOptions[0]];
            break;
            
        default:
            break;
    }
}

- (void)showDisclosureIndicator {
    self.disclosureIndicatorImageView.hidden = NO;
}

@end
