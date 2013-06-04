//
//  WZMessageViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-27.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessageViewController.h"
#import "WZMessage.h"

@interface WZMessageViewController ()

@end

@implementation WZMessageViewController
@synthesize message = _message;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
