//
//  WZPointRecordDetailViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPointRecordDetailViewController.h"
#import "WZContentViewController.h"


@interface WZPointRecordDetailViewController ()
@property (nonatomic,strong) WZContentViewController *contentViewController;
@end

@implementation WZPointRecordDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    if (!self.contentViewController) {
        self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
        [self addChildViewController:self.contentViewController];
        CGRect frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        self.contentViewController.view.frame = frame;
        self.contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:self.contentViewController.view];
        [self.contentViewController didMoveToParentViewController:self];
        self.contentView.clipsToBounds = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [self.contentViewController didMoveToParentViewController:nil];
        [self.contentViewController.view removeFromSuperview];
        [self.contentViewController removeFromParentViewController];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.contentViewController.pointRecord = self.pointRecord;
    self.contentViewController.type = self.type;
    CGRect frame = self.contentViewController.tableView.frame;
    frame.origin.y = - frame.size.height;
   self.contentViewController.tableView.frame = frame;
    
    [UIView animateWithDuration:6.0f animations:^(void){
       CGRect frame = self.contentViewController.tableView.frame;
        frame.origin.y = 0;
        self.contentViewController.tableView.frame = frame;
    }];
}

@end
