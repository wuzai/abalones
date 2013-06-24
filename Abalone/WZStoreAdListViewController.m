//
//  WZStoreAdListViewController.m
//  Abalone
//
//  Created by 陈 海涛 on 13-6-21.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZStoreAdListViewController.h"
#import "WZAd.h"
#import "WZAd+ForStore.h"
#import "WZADCell.h"
#import "WZmerchant.h"
#import "WZAdvertisementViewController.h"

@interface WZStoreAdListViewController ()
@property (nonatomic,strong) NSMutableArray *ads;
@end

static NSString *const adCellIdentifier = @"adCell";
@implementation WZStoreAdListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadData
{
    if (self.ads) {
        [self.ads removeAllObjects];
    }else{
        self.ads = [NSMutableArray array];
    }
    [self.ads addObjectsFromArray:[self.store.merchant.ads allObjects]];
    [self.ads sortedArrayUsingComparator:^NSComparisonResult(WZAd * obj1,WZAd * obj2){
        return  [obj2.showFromDate compare: obj1.showFromDate];
    }];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *classBundle = [NSBundle bundleForClass:[WZADCell class]];
    UINib *nib = [UINib nibWithNibName:@"AdCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:adCellIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchAdsForStoreSuccess:) name:kFetchAdsForStoreSuccessNotification object:nil];
}

- (void)fetchAdsForStoreSuccess:(NSNotification *)notification
{
    NSArray *ads = notification.userInfo[@"results"];
    if (ads.count) {
        [self loadData];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [WZAd fetchAdsForStore:self.store];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        self.store = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

-(void)dealloc
{
    self.store = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ads.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    WZADCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellIdentifier forIndexPath:indexPath];
    WZAd *ad = [self.ads objectAtIndex:indexPath.row];
    cell.AdImage.imageURL = [NSURL URLWithString:ad.postImage];
    cell.adTitle.text = ad.merchant.name;
    cell.adContent.text = ad.title;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WZAd *ad = [self.ads objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard  storyboardWithName:@"abalone" bundle:nil];
    WZAdvertisementViewController *adCtrl = (WZAdvertisementViewController *)[storyboard instantiateViewControllerWithIdentifier:@"adInfomation"];
    adCtrl.advertisement = ad;
    [self.navigationController pushViewController:adCtrl animated:YES];
}


@end
