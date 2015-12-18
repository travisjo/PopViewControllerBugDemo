//
//  ViewController.m
//  PopViewControllerBugDemo
//
//  Created by Travis Johnson on 12/18/15.
//  Copyright © 2015 Travis Johnson. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface RootViewController () {
    NSDictionary *metrics;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.fullScreenView = [UIView new];
    [self.view addSubview:self.fullScreenView];
    
    self.pushFirstViewControllerButton = [UIButton new];
    [self.pushFirstViewControllerButton setTitle:@"Push First View Controller" forState:UIControlStateNormal];
    [self.pushFirstViewControllerButton addTarget:self action:@selector(pushFirstViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenView addSubview:self.pushFirstViewControllerButton];
    
    self.pushSecondViewControllerButton = [UIButton new];
    [self.pushSecondViewControllerButton setTitle:@"Push Second View Controller" forState:UIControlStateNormal];
    [self.pushSecondViewControllerButton addTarget:self action:@selector(pushSecondViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenView addSubview:self.pushSecondViewControllerButton];
    
    [self setupAutoLayout];
}

- (void)setupAutoLayout
{
    [self.pushFirstViewControllerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.pushSecondViewControllerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.fullScreenView setTranslatesAutoresizingMaskIntoConstraints:NO];
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
                                                                        views:@{@"button": self.pushFirstViewControllerButton}]];
    [self.fullScreenView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(15)-[button2(==buttonWidth)]-(15)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"button2": self.pushSecondViewControllerButton}]];
    [self.fullScreenView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[button(==buttonHeight)]-(20)-[button2(==buttonHeight)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"button": self.pushFirstViewControllerButton,
                                                                                @"button2": self.pushSecondViewControllerButton}]];
    [self.view layoutIfNeeded];
}

- (void)pushFirstViewController
{
    FirstViewController *firstViewController = [FirstViewController new];
    firstViewController.title = @"First View Controller";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:firstViewController animated:YES];
    });
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
