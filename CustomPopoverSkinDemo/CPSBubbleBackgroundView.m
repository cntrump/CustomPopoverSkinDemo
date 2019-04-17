//
//  CPSBubbleBackgroundView.m
//  CustomPopoverSkinDemo
//
//  Created by John Blanco on 11/16/13.
//  Copyright (c) 2013 Rapture In Venice. LLC. All rights reserved.
//

#import "CPSBubbleBackgroundView.h"

@implementation CPSBubbleBackgroundView {
    UIPopoverArrowDirection _arrowDirection;
    CGFloat _arrowOffset;
    UIImageView *_backgroundImageView;
    UIImageView *_arrowImageView;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // background (for demo only, we don't actually need this for our background)
        UIImage *backgroundImage = [UIImage imageNamed:@"bubble-rect"];
        UIImage *resizableBackgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];

        _backgroundImageView = [[UIImageView alloc] initWithImage:resizableBackgroundImage];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;

        // round those corners!
        _backgroundImageView.layer.cornerRadius = 15;
        _backgroundImageView.layer.masksToBounds = YES;
        
        // arrow
        UIImage *arrowImage = [UIImage imageNamed:@"bubble-triangle"];

        _arrowImageView = [[UIImageView alloc] initWithImage:arrowImage];

        // make sure the arrow is on top of the background
        [self addSubview:_backgroundImageView];
        [self addSubview:_arrowImageView];
    }
    
    return self;
}

+ (UIEdgeInsets)contentViewInsets {
    // this determines the inset of the content area, defining popover edge "thickness"
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

+ (CGFloat)arrowBase {
    // width of your arrow image
    return 31.0;
}

+ (CGFloat)arrowHeight {
    // height of your arrow image
    return 70.0;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    // will ultimately be one of the four directions
    _arrowDirection = arrowDirection;
    [self setNeedsLayout];
}

- (UIPopoverArrowDirection)arrowDirection {
    return _arrowDirection;
}

- (void)setArrowOffset:(CGFloat)arrowOffset {
    _arrowOffset = arrowOffset;
    [self setNeedsLayout];
}

- (CGFloat)arrowOffset {
    return _arrowOffset;
}

+ (BOOL)wantsDefaultContentAppearance {
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat arrowHeight = [self.class arrowHeight];
    
    CGRect backgroundFrame = self.frame;
    CGPoint arrowCenter = CGPointZero;
    CGFloat arrowTransformInRadians = 0;

    if (self.arrowDirection == UIPopoverArrowDirectionUp) {
        backgroundFrame.origin.y += arrowHeight;
        backgroundFrame.size.height -= arrowHeight;
        arrowTransformInRadians = 0;
        arrowCenter = CGPointMake(backgroundFrame.size.width * 0.5 + self.arrowOffset, arrowHeight * 0.5);
    } else if (self.arrowDirection == UIPopoverArrowDirectionDown) {
        backgroundFrame.size.height -= arrowHeight;
        arrowTransformInRadians = M_PI;
        arrowCenter = CGPointMake(backgroundFrame.size.width * 0.5 + self.arrowOffset, backgroundFrame.size.height + arrowHeight * 0.5);
    } else if (self.arrowDirection == UIPopoverArrowDirectionLeft) {
        backgroundFrame.origin.x += arrowHeight;
        backgroundFrame.size.width -= arrowHeight;
        arrowTransformInRadians = M_PI_2 * 3.0;
        arrowCenter = CGPointMake(arrowHeight * 0.5, backgroundFrame.size.height * 0.5 + self.arrowOffset);
    } else if (self.arrowDirection == UIPopoverArrowDirectionRight) {
        backgroundFrame.size.width -= arrowHeight;
        arrowTransformInRadians = M_PI_2;
        arrowCenter = CGPointMake(backgroundFrame.size.width + arrowHeight * 0.5, backgroundFrame.size.height * 0.5 + self.arrowOffset);
    }
    
    _backgroundImageView.frame = backgroundFrame;
    _arrowImageView.center = arrowCenter;
    _arrowImageView.transform = CGAffineTransformMakeRotation(arrowTransformInRadians);
}

@end
