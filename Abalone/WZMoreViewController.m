//
//  WZMoreViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-3.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMoreViewController.h"
#import "WZUser+Me.h"

@interface WZMoreViewController ()
- (void)login;
- (void)recommend;
- (void)recommendUser;
@end

@implementation WZMoreViewController
@synthesize userLabel = _userLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([WZUser me]) {
        _userLabel.text = @"用户资料";
    }
    else
    {
        _userLabel.text = @"登录";
    }
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==0) {
        [self login];
    }
    else if (indexPath.section==1&&indexPath.row==1) {
        [self recommend];
    }
    else if (indexPath.section==1&&indexPath.row==2) {
        [self recommendUser];
    }
}

- (void)login
{
    if ([WZUser me]) {
        [self performSegueWithIdentifier:@"Profile" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"Login" sender:nil];
    }
}

- (void)recommend
{
    if ([WZUser me]) {
        [self performSegueWithIdentifier:@"Recommend" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"Login" sender:nil];
    }
}

- (void)recommendUser
{
    if ([WZUser me]) {
        [self performSegueWithIdentifier:@"RecommendUser" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"Login" sender:nil];
    }
}
@end
