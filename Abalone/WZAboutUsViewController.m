//
//  WZAboutUsViewController.m
//  MyCard
//
//  Created by 吾在 on 13-3-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAboutUsViewController.h"

@interface WZAboutUsViewController ()

@end

@implementation WZAboutUsViewController
@synthesize backgroundView = _backgroundView;

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
    if ([UIScreen mainScreen].bounds.size.height>960) {
        _backgroundView.image = [UIImage imageNamed:@"about-568h.png"];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goWeb:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"www.5zzg.com"]]];
}

- (IBAction)call:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://02558506331"]];
    
    
    
}
@end
