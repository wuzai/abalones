//
//  WZStoreDetailViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStoreDetailViewController.h"
#import "defines.h"
#import "WZMerchant.h"
#import "WZMerchant+Networks.h"
#import "WZStore+NetWorks.h"
#import "WZShowServiceItemDetailViewController.h"
#import "WZOtherStoresViewController.h"
#import "WZAddCommentViewController.h"
#import "WZMapViewController.h"

@interface WZStoreDetailViewController ()

@end

@implementation WZStoreDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.storeNameLabel.text = self.store.storeName;
    self.storeNameLabel.backgroundColor = [UIColor redColor];
    self.storeImageView.imageURL = [NSURL URLWithString:self.store.vipImage];
    self.tableView.tableHeaderView = self.storeImageView;
    self.storeDetailInfoViewController.store = self.store;
    self.serviceItemListViewController.store = self.store;
    self.commentListViewController.merchant = self.store.merchant;
    self.storeAdListViewController.store = self.store;
    
    [self.storeAdListViewController viewWillAppear:animated];
    
    [self.store.merchant fetchMerchant];
    [self updateViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"门店详情";
    self.segmentedControl.selectedSegmentIndex = 1;
    self.segmentedControl.interItemSpace = 30.0f;
    self.segmentedControl.viewForBaselineLayout.backgroundColor=[UIColor redColor];
    
    if (!self.contentTableViews) {
        self.contentTableViews = [NSMutableArray arrayWithCapacity:3];
    }
    
    if (!self.storeDetailInfoViewController) {
        self.storeDetailInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storeInfo"];
    }
    
    [self addChildViewController:self.storeDetailInfoViewController];
    CGRect frame = self.storeDetailInfoViewController.tableView.frame;
    frame.origin.y = 0;
    frame.size = self.contentView.frame.size;
    self.storeDetailInfoViewController.tableView.frame = frame;
    [self.contentView addSubview:self.storeDetailInfoViewController.tableView];
    [self.storeDetailInfoViewController didMoveToParentViewController:self];
    
    if (!self.serviceItemListViewController) {
        self.serviceItemListViewController = [WZServiceItemListViewController new];
    }
    [self addChildViewController:self.serviceItemListViewController];
    frame = self.serviceItemListViewController.tableView.frame;
    frame.origin.y = 0;
    frame.size = self.contentView.frame.size;
    self.serviceItemListViewController.tableView.frame = frame;
    [self.contentView addSubview:self.serviceItemListViewController.tableView];
    [self.serviceItemListViewController didMoveToParentViewController:self];
    
    if (!self.commentListViewController) {
        self.commentListViewController = [WZCommentListViewController new];
    }
    [self addChildViewController:self.commentListViewController];
    frame = self.commentListViewController.tableView.frame;
    frame.origin.y = 0;
    frame.size = self.contentView.frame.size;
    self.commentListViewController.tableView.frame = frame;
    [self.contentView addSubview:self.commentListViewController.tableView];
    [self.commentListViewController didMoveToParentViewController:self];
    
    if (!self.storeAdListViewController) {
        self.storeAdListViewController = [WZStoreAdListViewController new];
    }
    [self addChildViewController:self.storeAdListViewController];
    frame = self.storeAdListViewController.tableView.frame;
    frame.origin.y = 0;
    frame.size = self.contentView.frame.size;
    self.storeAdListViewController.tableView.frame = frame;
    [self.contentView addSubview:self.storeAdListViewController.tableView];
    [self.storeAdListViewController didMoveToParentViewController:self];
    
    [self.contentTableViews insertObject:self.storeDetailInfoViewController atIndex:0];
    [self.contentTableViews insertObject:self.serviceItemListViewController atIndex:1];
    [self.contentTableViews insertObject:self.commentListViewController atIndex:2];
    [self.contentTableViews insertObject:self.storeAdListViewController atIndex:3];
    
    self.serviceItemListViewController.tableView.hidden = NO;
    self.storeDetailInfoViewController.tableView.hidden = YES;
    self.commentListViewController.tableView.hidden = YES;
    self.storeAdListViewController.tableView.hidden = YES;
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchMerchantSuccess:) name:FetchMerchantSuccess object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchMerchantFail:) name:FetchMerchantFail object:nil];
}



//请求商户成功
-(void)fetchMerchantSuccess:(NSNotification *)notification
{
    WZMerchant *merchant = [[notification object] lastObject];
    self.storeNameLabel.text = self.store.storeName;
    self.storeImageView.imageURL = [NSURL URLWithString:merchant.logo];
    
    [self updateViews];
}

-(void)updateViews
{
    self.storeNameLabel.text = self.store.storeName;
    self.storeImageView.imageURL = [NSURL URLWithString:self.store.vipImage];
    [self.storeDetailInfoViewController updateViews];
    [self.serviceItemListViewController updateViews];
    [self.commentListViewController updateViews];
}

//请求商户失败
-(void)fetchMerchantFail:(NSNotification *)notification
{
    NSLog(@"%@",[notification object]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        self.view = nil;
        [self.storeDetailInfoViewController didMoveToParentViewController:nil];
        [self.storeDetailInfoViewController.tableView removeFromSuperview];
        [self.storeDetailInfoViewController removeFromParentViewController];
        self.storeDetailInfoViewController.tableView = nil;
        
        [self.serviceItemListViewController didMoveToParentViewController:nil];
        [self.serviceItemListViewController.tableView removeFromSuperview];
        [self.serviceItemListViewController removeFromParentViewController];
        self.serviceItemListViewController.tableView = nil;
        
        [self.commentListViewController didMoveToParentViewController:nil];
        [self.commentListViewController.tableView removeFromSuperview];
        [self.commentListViewController removeFromParentViewController];
        self.commentListViewController.tableView = nil;
        
        [self.storeAdListViewController didMoveToParentViewController:nil];
        [self.storeAdListViewController.tableView removeFromSuperview];
        [self.storeAdListViewController removeFromParentViewController];
        self.storeAdListViewController.tableView = nil;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:FetchMerchantSuccess object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:FetchMerchantFail object:nil];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.tableView.contentOffset.y >= self.storeImageView.bounds.size.height) {
        CGPoint p = CGPointMake(0, self.storeImageView.bounds.size.height);
        scrollView.contentOffset = p;
        self.storeDetailInfoViewController.tableView.scrollEnabled = YES;
        self.serviceItemListViewController.tableView.scrollEnabled = YES;
        self.commentListViewController.tableView.scrollEnabled = YES;
        self.storeAdListViewController.tableView.scrollEnabled = YES;
    }else{
         self.storeDetailInfoViewController.tableView.scrollEnabled = NO;
         self.serviceItemListViewController.tableView.scrollEnabled = NO;
         self.commentListViewController.tableView.scrollEnabled = NO;
         self.storeAdListViewController.tableView.scrollEnabled = NO;
    }
   
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (indexPath.section == 0) {
        if (row == 0) {
            return 0;
        }else if(row == 1){
            return 70;
        }else{
            if (IPHONE5) {
                return 385;
            }
            return 297;
        }
    }else if(indexPath.section == 1){
        return 200;
    }
    
    
}


- (IBAction)changeView:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
       UISegmentedControl *segment = (UISegmentedControl *)sender;
        NSInteger selectedIndex = segment.selectedSegmentIndex;
        for (int i=0; i<self.contentTableViews.count; i++) {
            if (i == selectedIndex) {
                [[self.contentTableViews[i] tableView] setHidden:NO];
            }else{
                [[self.contentTableViews[i] tableView] setHidden:YES];
            }
        }
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showServiceItemInfo"]) {
        if ([segue.destinationViewController isKindOfClass:[WZShowServiceItemDetailViewController class]]) {
            WZShowServiceItemDetailViewController *showServiceItemDetailViewController = (WZShowServiceItemDetailViewController *)segue.destinationViewController;
            showServiceItemDetailViewController.serviceItem = sender;
            showServiceItemDetailViewController.store = self.store;
        } 
    }else if([segue.identifier isEqualToString:@"showOtherStores"]){
        if ([segue.destinationViewController isKindOfClass:[WZOtherStoresViewController class]]) {
            WZOtherStoresViewController *otherStoresViewController = (WZOtherStoresViewController *)segue.destinationViewController;
            NSMutableArray *stores = [NSMutableArray arrayWithArray:[self.store.merchant.stores allObjects]];
            [stores removeObject:self.store];
            otherStoresViewController.otherStores = stores;
        }
    }else if([segue.identifier isEqualToString:@"addComment"]){
        if ([segue.destinationViewController isKindOfClass:[WZAddCommentViewController class]]) {
            WZAddCommentViewController *addCommentViewController = (WZAddCommentViewController *)segue.destinationViewController;
            addCommentViewController.merchant = self.store.merchant;
        }
    }else if([segue.identifier isEqualToString:@"showMap"]){
        if ([segue.destinationViewController isKindOfClass:[WZMapViewController class]]) {
            WZMapViewController *mapctrl = (WZMapViewController *)segue.destinationViewController;
            mapctrl.location = self.store.location;
        }
    }
}

@end













