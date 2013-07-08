//
//  WZLicenseViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZLicenseViewController.h"
#import "UILabel+Zoom.h"
#import "WZRegisterViewController.h"
#import "WZUser+Me.h"

@interface WZLicenseViewController ()

@end

@implementation WZLicenseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [textLabel zoom];
    CGFloat height = textLabel.frame.size.height;
    CGRect frame = contenView.frame;
    frame.size.height = height+27;
    contenView.frame = frame;
    backgroundImageView.frame = frame;
    UIImage *image = backgroundImageView.image;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    backgroundImageView.image = image;
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"text.png"]]];
    [scrollView setContentSize:frame.size];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSArray *controllers = self.navigationController.viewControllers;
    if ([[controllers objectAtIndex:[controllers count]-2] isKindOfClass:[WZRegisterViewController class]] && [WZUser me]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
