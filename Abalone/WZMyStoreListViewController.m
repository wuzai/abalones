//
//  WZMyStoreListViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMyStoreListViewController.h"
#import "WZStore+Mine.h"
#import "WZUser+Me.h"
#import "WZFetchService.h"
#import "WZMyStoreListCell.h"
#import "WZMerchant.h"
#import "WZLocation.h"
#import "WZMyStoresViewController.h"
#import "WZShowMyStoreDetailViewController.h"

@interface WZMyStoreListViewController ()
@property (nonatomic,strong) NSMutableArray *myStoreList;
@end


NSString *const cellIdenitfier = @"MyStoreListCell";
@implementation WZMyStoreListViewController

-(void)addRefreshViewController
{
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshControlEnventValueChanged) forControlEvents:UIControlEventValueChanged];
}

//进入登陆界面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
         NSLog(@"%d",buttonIndex);

        if(buttonIndex==0)
        {
           [self.parentViewController performSegueWithIdentifier:@"gotoLogin" sender:nil];
        }
        
    
}


-(void)refreshControlEnventValueChanged
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中。。。"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceSuccess:) name:kFetchServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceFail:) name:kFetchServiceFailNotificationKey object:nil];
    if (![WZUser me]) {
      [self fetchServiceFail:nil];
        [[[UIAlertView alloc]initWithTitle:@"提示" message: @"请先登陆 " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    if (![WZFetchService fetchServiceByUser:[WZUser me]]) {
        [self fetchServiceFail:nil];
    }
}

-(void)fetchServiceSuccess:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceFailNotificationKey object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self loadData];
}

-(void)fetchServiceFail:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceFailNotificationKey object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRefreshViewController];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSBundle *classBundle = [NSBundle bundleForClass:[WZMyStoreListCell class]];
    UINib *nib = [UINib nibWithNibName:@"MyStoreListCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdenitfier];
    
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
    return self.myStoreList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.myStoreList.count) {
        WZStore *store = [self.myStoreList objectAtIndex:indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitfier];
        if ([cell isKindOfClass:[WZMyStoreListCell class]]) {
            WZMyStoreListCell *myStoreCell = (WZMyStoreListCell *)cell;
            myStoreCell.storeBigImage.imageURL = [NSURL URLWithString:store.vipImage];
            myStoreCell.storeBigImage.placeholderImage = [UIImage imageNamed:@"商户图标占位"];
            myStoreCell.LogoImge.imageURL = [NSURL URLWithString:store.merchant.logo];
            myStoreCell.LogoImge.placeholderImage = [UIImage imageNamed:@"商户logo占位"];
            myStoreCell.storeText.text = store.slogan;
            myStoreCell.storeName.text = store.storeName;
            
            if (self.selectedIndex == 1) {
                myStoreCell.distanceFromHere.hidden = NO;
                CLLocation *storeLocation = [[CLLocation alloc] initWithLatitude:store.location.latitude.doubleValue longitude:store.location.longitude.doubleValue];
                if (self.here) {
                    myStoreCell.distanceFromHere.text = [NSString stringWithFormat:@"%0.3fKM",[self.here distanceFromLocation:storeLocation]/1000];
                }else{
                    myStoreCell.distanceFromHere.text = @"";
                }
                
            }else{
                myStoreCell.distanceFromHere.hidden = YES;
            }
        }
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myStoreList.count) {
        return 135.0;
    }else{
        return self.view.frame.size.height;
    }
    
}

-(void)loadData
{
    if ([WZUser me]) {
       self.myStoreList = [WZStore mine];
        [self sort];
    
    }else{
         [self.myStoreList removeAllObjects];
         [self.tableView reloadData];
    }
    
    WZMyStoresViewController *parent = (WZMyStoresViewController *)self.parentViewController;
    if (!self.myStoreList.count) {
        parent.noStoreWarnning.hidden = NO;
        [parent.view bringSubviewToFront: parent.noStoreWarnning];
    }else {
        parent.noStoreWarnning.hidden = YES;
    }
}

-(void)sort
{
    if (!self.selectedIndex) {
        self.selectedIndex = 3;
    }
    if (self.selectedIndex == 1) {
        [self sortWithLocation];
        [self.tableView reloadData];
    }else{
        [self.myStoreList sortUsingComparator:self.comparator[self.selectedIndex]];
        [self.tableView reloadData];
    }    
}

-(void)sortWithLocation
{
    [self.myStoreList sortUsingComparator:^(WZStore  *s1,WZStore *s2){
        
        CLLocation *l1 = [[CLLocation alloc] initWithLatitude:[s1.location.latitude doubleValue] longitude:[s1.location.longitude doubleValue]];
        CLLocation *l2 = [[CLLocation alloc] initWithLatitude:[s2.location.latitude doubleValue] longitude:[s2.location.longitude doubleValue]];
        
        
        return [[NSNumber numberWithDouble:[self.here distanceFromLocation:l1]] compare: [NSNumber numberWithDouble: [self.here distanceFromLocation:l2]]] ;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myStoreList.count) {
//        WZShowMyStoreDetailViewController *showMyStoreDetailVC = [[WZShowMyStoreDetailViewController alloc] init];
//        showMyStoreDetailVC.store = self.myStoreList[indexPath.row];
//        [self.parentViewController.navigationController pushViewController:showMyStoreDetailVC animated:YES];
        [self.parentViewController performSegueWithIdentifier:@"showMyStoreDetail" sender:self.myStoreList[indexPath.row]];
    }else{
        return;
    }
}

@end
