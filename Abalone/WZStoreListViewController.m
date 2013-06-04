//
//  WZStoreListController.m
//  Abalone
//
//  Created by 吾在 on 13-4-3.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStoreListViewController.h"
#import "WZStoreCell.h"
#import "WZMerchant.h"
#import "WZMember.h"
#import "WZNoStoreCell.h"
#import "WZMember.h"
#import "WZNoStoreCell.h"
#import "EGOImageView.h"
#import "WZStore.h"
#import "defines.h"
#import "WZMerchant+Networks.h"
#import "WZLocation.h"
#import "WZStore+serviceItems.h"
#import "WZStoresViewController.h"
#import "WZUser+Me.h"

@interface WZStoreListViewController ()
{
    
}

@end


static NSString *const cellIdentifier = @"storeCell";
static NSString *const noCellIdentifier = @"noStoreCell";

@implementation WZStoreListViewController

-(void)addRefreshViewController
{
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshControlEnventValueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshControlEnventValueChanged
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中。。。"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchMerchantListSuccess:) name:SynMerchantListSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchMerchantListFail:) name:SynMerchantListFail object:nil];
    [WZMerchant fetchMerchantList];
}

-(void)fetchMerchantListSuccess:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SynMerchantListSuccess object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SynMerchantListFail object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self loadData];
}

-(void)fetchMerchantListFail:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SynMerchantListSuccess object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SynMerchantListFail object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRefreshViewController];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
    
    //注册相应UITableViewCell
    NSBundle *classBundle = [NSBundle bundleForClass:[WZStoreCell class]];
    UINib *cellNib = [UINib nibWithNibName:@"StoreCell" bundle:classBundle];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellIdentifier];
    
    classBundle = [NSBundle bundleForClass:[WZNoStoreCell class]];
    cellNib = [UINib nibWithNibName:@"NoStoreCell" bundle:classBundle];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:noCellIdentifier];
   
    
    
    self.comparator = @[
                        ^(WZStore *s1, WZStore  *s2){
                            return [s2.merchant.memberNumber compare:s1.merchant.memberNumber];
                        },
                         ^(WZStore *s1, WZStore *s2){
                             return [s1.coordinate compare:s2.coordinate ];},
                         ^(WZStore *s1, WZStore *s2){
                             return [s2.createTime compare:s1.createTime];
                         },
                         ^(WZStore *s1, WZStore *s2){
                             return [s2.merchant.score compare:s1.merchant.score];
                         }
                         ];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.tableView.window == nil) {
        self.tableView = nil;
    }
}

#pragma mark -
#pragma mark tableview delegate and dataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return [self.storesArray count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.storesArray.count) {
        WZStore *store = [self.storesArray objectAtIndex:indexPath.row];
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ([cell isKindOfClass:[WZStoreCell class]]) {
            WZStoreCell *storeCell = (WZStoreCell *)cell;
            storeCell.storeNameLabel.text = store.storeName;
            storeCell.storeImage.placeholderImage = [UIImage imageNamed:@"小南国"];
            storeCell.merchantLogoImage.placeholderImage = [UIImage imageNamed:@"小南国"];
            storeCell.storeImage.imageURL = [NSURL URLWithString:store.rectangleImage];
            storeCell.merchantLogoImage.imageURL = [NSURL URLWithString:store.merchant.logo];
            storeCell.storeTypeLabel.text = store.slogan;
            storeCell.storeNameLabel.text = store.storeName;
            if (self.selectedIndex == 1) {
                storeCell.distanceFromHere.hidden = NO;
                CLLocation *storeLocation = [[CLLocation alloc] initWithLatitude:store.location.latitude.doubleValue longitude:store.location.longitude.doubleValue];
                if (self.here) {
                    storeCell.distanceFromHere.text = [NSString stringWithFormat:@"%0.3fKM",[self.here distanceFromLocation:storeLocation]/1000];
                }else{
                    storeCell.distanceFromHere.text = @"";
                }
                
            }else{
                storeCell.distanceFromHere.hidden = YES;
            }
        }
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.storesArray.count) {
        return 100.0;
    }
    return 0.0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.storesArray) {
        return;
    }
    [self.parentViewController performSegueWithIdentifier:@"showStoreDetail" sender:self.storesArray[indexPath.row]];
}

-(void)loadData
{
    if (!self.storesArray) {
        self.storesArray = [NSMutableArray array];
    }else{
        [self.storesArray removeAllObjects];
    }
    NSMutableArray *stores = [NSMutableArray arrayWithArray:[WZStore  allObjects]];
    if ([WZUser me]) {
        WZUser *me = [WZUser me];
        NSMutableArray *deletes = [NSMutableArray array];
        [me.members enumerateObjectsUsingBlock:^(id obj,BOOL *finish){
            WZMember *member = (WZMember *)obj;
            [deletes addObjectsFromArray:[member.merchant.stores allObjects]];
        }];
        [stores removeObjectsInArray:deletes];
    }
    if (stores.count) {
        [self.storesArray addObjectsFromArray:stores];
        [self checkType];
        [self sort];
    }
    WZStoresViewController *parent = (WZStoresViewController *)self.parentViewController;
    if (!self.storesArray.count) {
        parent.noStoresWarnning.hidden = NO;
        [parent.contentView  bringSubviewToFront:parent.noStoresWarnning];
    }else{
        parent.noStoresWarnning.hidden = YES;
        
    }
}

-(void)checkType
{
    if ([self.parentViewController isKindOfClass:[WZStoresViewController class]]) {
        WZStoresViewController *storesViewController = (WZStoresViewController *) self.parentViewController;
        NSString *type = storesViewController.storeTypeSelectorViewController.selectedType;
        if ([type isEqualToString:@"所有类型"] || !type ) {
            return;
        }
        NSMutableArray *deleteArray = [NSMutableArray array];
        [self.storesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop){
            WZStore *store =(WZStore *)obj;
            if (![store.type isEqualToString:type]) {
                [deleteArray addObject:store];
            }
        }];
        if (deleteArray.count) {
            [self.storesArray removeObjectsInArray:deleteArray];
        }
    }
   
    
}

#pragma mark -

-(void)sort
{
    if (!self.selectedIndex) {
        self.selectedIndex = 3;
    }
    if (self.selectedIndex == 1) {
        [self sortWithLocation];
        [self.tableView reloadData];
    }else{
        [self.storesArray sortUsingComparator:self.comparator[self.selectedIndex]];
        for (WZStore *store in self.storesArray) {
             NSLog(@"(%i,%@,%i)",store.merchant.memberNumber.intValue,store.createTime,store.merchant.score.intValue);
        }
       
        [self.tableView reloadData];
    }
   
}

-(void)sortWithLocation
{
    [self.storesArray sortUsingComparator:^(WZStore  *s1,WZStore *s2){
         
        CLLocation *l1 = [[CLLocation alloc] initWithLatitude:[s1.location.latitude doubleValue] longitude:[s1.location.longitude doubleValue]];
        CLLocation *l2 = [[CLLocation alloc] initWithLatitude:[s2.location.latitude doubleValue] longitude:[s2.location.longitude doubleValue]];
        
        
        return [[NSNumber numberWithDouble:[self.here distanceFromLocation:l1]] compare: [NSNumber numberWithDouble: [self.here distanceFromLocation:l2]]] ;
    }];
} 

@end



















