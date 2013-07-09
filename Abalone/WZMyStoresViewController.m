//
//  WZMyStoresViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMyStoresViewController.h"
#import "WZMyStoreListViewController.h"
#import "WZUser+Me.h"
#import "WZLocation.h"
#import  <CoreLocation/CoreLocation.h>
#import "WZMerchant+Networks.h"
#import "WZMyStoreDetailViewController.h"

@interface WZMyStoresViewController ()
@property (nonatomic,strong) WZMyStoreListViewController *myStoreListViewController;
@end

@implementation WZMyStoresViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib
{
    NSLog(@"%@",self.view);
}




- (void)viewDidLoad
{
    [super viewDidLoad];
     self.hidesBottomBarWhenPushed = YES;
    
//    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(addStores:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    self.segmentControl.selectedSegmentIndex = 3;
	if (!self.myStoreListViewController) {
        self.myStoreListViewController = [WZMyStoreListViewController new];
        [self addChildViewController:self.myStoreListViewController];
        CGRect frame = self.myStoreListViewController.tableView.frame;
        frame.origin.y = 40;
        frame.size.height = self.view.frame.size.height;
        self.myStoreListViewController.tableView.frame = frame;
        NSLog(@"%@",NSStringFromCGRect(self.myStoreListViewController.tableView.frame));
         self.myStoreListViewController.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.myStoreListViewController.tableView];
        [self.myStoreListViewController didMoveToParentViewController:self];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSuccess:) name:@"locationSuccess" object:nil];
    NSLog(@"hello%@",NSStringFromCGRect(self.view.frame));
}

-(void)locationSuccess:(NSNotification*) notification
{
    WZLocationContrl *locationControl = [WZLocationContrl sharedInstance];
    
    if(locationControl.locationKnown) {
        self.myStoreListViewController.here = locationControl.currentLocation;
        if (self.segmentControl.selectedSegmentIndex == 1) {
            self.myStoreListViewController.selectedIndex = self.segmentControl.selectedSegmentIndex;
            [self.myStoreListViewController sort];
        }
    }
    
    
}

//
//-(void)addStores:(id)sender
//{
//    [self performSegueWithIdentifier:@"addStores" sender:nil];
//}

-(IBAction)sort:(UISegmentedControl *)segmentcontrol{
    if (segmentcontrol.selectedSegmentIndex == 1) {
//        [self location];
//        self.myStoreListViewController.here = self.locationManager.location;
//        [self.locationManager stopUpdatingLocation];
        WZLocationContrl *locationControl = [WZLocationContrl sharedInstance];
        [locationControl start];
        if(locationControl.locationKnown) {
            self.myStoreListViewController.here = locationControl.currentLocation;
        }
    }else if (segmentcontrol.selectedSegmentIndex == 0) {
        [self updateMerchantMemberNum];
    }
    
     self.myStoreListViewController.selectedIndex =segmentcontrol.selectedSegmentIndex;
    [ self.myStoreListViewController sort];
    
    
}



-(void)updateMerchantMemberNum
{
     [WZMerchant fetchMerchantList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [self.myStoreListViewController didMoveToParentViewController:nil];
        [self.myStoreListViewController.tableView removeFromSuperview];
        [self.myStoreListViewController removeFromParentViewController];
        
         [[NSNotificationCenter defaultCenter] removeObserver:self name:@"locationSuccess" object:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
     NSLog(@"hello%@",NSStringFromCGRect(self.view.frame));
    CGRect frame = self.view.frame;
    frame.size.height = 416;
    self.view.frame = frame;
    self.view.backgroundColor = [UIColor redColor];
    if ([WZUser me]) {
        [WZFetchService fetchServiceByUser:[WZUser me]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceSuccess:) name:kFetchServiceSuccessNotificationKey  object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceFail:) name:kFetchServiceFailNotificationKey  object:nil];

}



-(void)fetchServiceSuccess:(NSNotification *)notification
{
    [self.myStoreListViewController loadData];
}

-(void)fetchServiceFail:(NSNotification *)notification
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kFetchServiceFailNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceSuccessNotificationKey object:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMyStoreDetail"]) {
        if ([segue.destinationViewController isKindOfClass:[WZMyStoreDetailViewController class]]) {
            WZMyStoreDetailViewController *storeDetailViewController = (WZMyStoreDetailViewController *)segue.destinationViewController;
            storeDetailViewController.store = sender;
        }
    }
}

- (IBAction)addStores:(id)sender {
    [self performSegueWithIdentifier:@"addStores" sender:nil];
}

//-(void)addStores:(id)sender
//{
//    [self performSegueWithIdentifier:@"addStores" sender:nil];
//}
@end
