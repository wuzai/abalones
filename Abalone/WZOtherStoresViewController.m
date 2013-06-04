//
//  WZOtherStoresViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZOtherStoresViewController.h"
#import "WZStore.h"
#import "WZStoreListViewController.h"
#import "WZStoreCell.h"
#import "WZMerchant.h"
#import "defines.h"
#import "WZStoreDetailViewController.h"

@interface WZOtherStoresViewController ()

@end

static NSString *const cellIdentifier = @"storeCell";
@implementation WZOtherStoresViewController

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
    NSBundle *classBundle = [NSBundle bundleForClass:[WZStore class]];
    UINib *nib = [UINib nibWithNibName:@"StoreCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    self.title = @"其他门店";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.otherStores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    WZStore *store = [self.otherStores objectAtIndex:indexPath.row];
    if ([cell isKindOfClass:[WZStoreCell class]]) {
        WZStoreCell *storeCell = (WZStoreCell *)cell;
        storeCell.merchantLogoImage.imageURL = [NSURL URLWithString:store.merchant.logo];
        storeCell.storeNameLabel.text = store.storeName;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.otherStores.count) {
        return 88.0;
    }else{
        if (IPHONE5) {
            return 411;
        }else{
            return 323;
        }
    }
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.otherStores.count) {
        WZStoreDetailViewController  *storeDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"storeDetail"];
        storeDetail.store = [self.otherStores objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:storeDetail animated:YES];
    }
   
}





@end
