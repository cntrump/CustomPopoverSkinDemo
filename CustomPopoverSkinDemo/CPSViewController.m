//
//  CPSViewController.m
//  CustomPopoverSkinDemo
//
//  Created by John Blanco on 11/16/13.
//  Copyright (c) 2013 Rapture In Venice. LLC. All rights reserved.
//

#import "CPSViewController.h"
#import "CPSBubbleBackgroundView.h"

@interface CPSViewController ()

@property (strong, nonatomic) UIPopoverController *foxPopoverController;

@end

@implementation CPSViewController

- (IBAction)middleTapped:(UIButton *)sender {
    static UIPopoverArrowDirection arrowDirection = UIPopoverArrowDirectionDown;
    
    // popover w/ skin
    [self showFoxPopoverFromRect:sender.frame arrowDirection:arrowDirection];
    
    // rotate arrow direction
    if (arrowDirection == UIPopoverArrowDirectionUp) {
        arrowDirection = UIPopoverArrowDirectionLeft;
    } else if (arrowDirection == UIPopoverArrowDirectionLeft) {
        arrowDirection = UIPopoverArrowDirectionDown;
    } else if (arrowDirection == UIPopoverArrowDirectionDown) {
        arrowDirection = UIPopoverArrowDirectionRight;
    } else if (arrowDirection == UIPopoverArrowDirectionRight) {
        arrowDirection = UIPopoverArrowDirectionUp;
    }
}

- (IBAction)topLeftTapped:(UIButton *)sender {
    static UIPopoverArrowDirection arrowDirection = UIPopoverArrowDirectionUp;
    
    // popover w/ skin
    [self showFoxPopoverFromRect:sender.frame arrowDirection:arrowDirection];
    
    // rotate arrow direction
    if (arrowDirection == UIPopoverArrowDirectionUp) {
        arrowDirection = UIPopoverArrowDirectionLeft;
    } else if (arrowDirection == UIPopoverArrowDirectionLeft) {
        arrowDirection = UIPopoverArrowDirectionUp;
    }
}

- (IBAction)bottomRightTapped:(UIButton *)sender {
    static UIPopoverArrowDirection arrowDirection = UIPopoverArrowDirectionDown;
    
    // popover w/ skin
    [self showFoxPopoverFromRect:sender.frame arrowDirection:arrowDirection];
    
    // rotate arrow direction
    if (arrowDirection == UIPopoverArrowDirectionDown) {
        arrowDirection = UIPopoverArrowDirectionRight;
    } else if (arrowDirection == UIPopoverArrowDirectionRight) {
        arrowDirection = UIPopoverArrowDirectionDown;
    }
}

- (void)showFoxPopoverFromRect:(CGRect)rect arrowDirection:(UIPopoverArrowDirection)arrowDirection {
    UIViewController *cpsViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"CPSFoxViewController"];
    cpsViewController.preferredContentSize = CGSizeMake(200, 200);
    
    self.foxPopoverController = [[UIPopoverController alloc] initWithContentViewController:cpsViewController];
    self.foxPopoverController.delegate = self;
    self.foxPopoverController.popoverBackgroundViewClass = [CPSBubbleBackgroundView class];
    [self.foxPopoverController presentPopoverFromRect:rect inView:self.view permittedArrowDirections:arrowDirection animated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.foxPopoverController = nil;
}

@end
