//
//  FirstViewController.m
//  PopViewControllerBugDemo
//
//  Created by Travis Johnson on 12/18/15.
//  Copyright © 2015 Travis Johnson. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController () {
    NSDictionary *metrics;
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.fullScreenView = [UIView new];
    [self.view addSubview:self.fullScreenView];
    
    self.pushViewControllerButton = [UIButton new];
    [self.pushViewControllerButton setTitle:@"Push Second View Controller" forState:UIControlStateNormal];
    [self.pushViewControllerButton addTarget:self action:@selector(pushSecondViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenView addSubview:self.pushViewControllerButton];
    
    [self setupAutoLayout];
}

- (void)setupAutoLayout
{
    [self.fullScreenView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.pushViewControllerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view removeConstraints:self.view.constraints];
    
    metrics = @{@"screenHeight": @([UIScreen mainScreen].bounds.size.height),
                @"screenWidth": @([UIScreen mainScreen].bounds.size.width),
                @"buttonWidth": @([UIScreen mainScreen].bounds.size.width - (15*2)),
                @"buttonHeight": @(33)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[fullScreenView(==screenWidth)]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"fullScreenView": self.fullScreenView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[fullScreenView(==screenHeight)]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"fullScreenView": self.fullScreenView}]];
    
    [self.fullScreenView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(15)-[button(==buttonWidth)]-(15)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"button": self.pushViewControllerButton}]];
    [self.fullScreenView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[button(==buttonHeight)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"button": self.pushViewControllerButton}]];
    [self.view layoutIfNeeded];
}

- (void)pushSecondViewController
{
    SecondViewController *secondViewController = [SecondViewController new];
    secondViewController.title = @"Second View Controller";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:secondViewController animated:YES];
    });
}

@end
