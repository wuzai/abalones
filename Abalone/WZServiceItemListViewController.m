//
//  WZServiceItemListViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZServiceItemListViewController.h"
#import "WZServiceItem.h"
#import "WZStore+serviceItems.h"
#import <RestKit/RestKit.h>
#import "WZServiceItemCell.h"

@interface WZServiceItemListViewController ()

@end

static NSString *const cellIdentifier = @"serviceItemCell";
@implementation WZServiceItemListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    NSBundle *classBundle = [NSBundle bundleForClass:[WZServiceItemCell class]];
    UINib *nib = [UINib nibWithNibName:@"serviceItemCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViews];
}

-(void)updateViews
{
    self.serviceItems = self.store.serviceItems;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
       
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.serviceItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[WZServiceItemCell class]]) {
        WZServiceItem *serviceItem = [self.serviceItems objectAtIndex:indexPath.row];
        WZServiceItemCell *serviceItemCell = (WZServiceItemCell *)cell;
        serviceItemCell.serviceItemImage.imageURL = [NSURL URLWithString:serviceItem.posterImage];
        serviceItemCell.serviceItemTitle.text = serviceItem.serviceItemName;
        serviceItemCell.serviceItemContent.lineBreakMode = NSLineBreakByTruncatingTail;
        serviceItemCell.serviceItemContent.numberOfLines = 0;
        serviceItemCell.serviceItemContent.text = serviceItem.promptIntro;
    }
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.parentViewController performSegueWithIdentifier:@"showServiceItemInfo" sender:[self.serviceItems objectAtIndex:indexPath.row]];
}



@end
