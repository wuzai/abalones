//
//  WZStoresViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-2.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStoresViewController.h"
#import "WZUser+Me.h"
#import "WZMerchant+Networks.h"
#import "WZStoreDetailViewController.h"
#import "WZMultiImageView.h"
#import "WZAd.h"
#import "WZAd+Networks.h"
#import "WZLocationContrl.h"
#import "WZStoreTypeSelectorViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "WZDeleteUserMessage.h"

#pragma mark - 配置参数
static const CGFloat LeftMenuMaxWidth = 120;
static const CGFloat MaxAlpha = 0.5;
static const CGFloat MinScale = 0.95;
static const CGFloat speedPixel = 0.0015;
#pragma mark -

@interface WZStoresViewController ()
{
    IBOutlet UIView *_advertisementsBackground;
    IBOutlet WZMultiImageView *_advertisementsView;
    NSMutableArray *_advertisements;
    UIBarButtonItem *_advertisementsItem;
}
- (void)loadAdvertisements;
- (void)reloadAdvertisements;
- (void)advertisementsDownloadSucceed:(NSNotification *)notification;

@property CAGradientLayer *leftLayer;
@end

@implementation WZStoresViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.clipsToBounds = NO;
    _advertisementsItem = self.navigationItem.rightBarButtonItem;
    self.title = @"商户";
    self.segmentControl.selectedSegmentIndex = 3;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView.userInteractionEnabled = YES;
   
    
    self.storeTypeSelectorViewController = [WZStoreTypeSelectorViewController new];
    [self addChildViewController:self.storeTypeSelectorViewController];
    CGRect typeFrame = self.storeTypeSelectorViewController.view.frame;
    typeFrame.origin.y = 0;
    typeFrame.size.width = LeftMenuMaxWidth + 50;
    self.storeTypeSelectorViewController.view.frame = typeFrame;
    self.leftLayer = [CAGradientLayer layer];
    self.leftLayer.frame = self.storeTypeSelectorViewController.view.bounds;
    self.leftLayer.colors = @[(id)[UIColor colorWithWhite:0.0f alpha:MaxAlpha].CGColor,(id)[UIColor colorWithWhite:0.0f alpha:MaxAlpha].CGColor];
    [self.storeTypeSelectorViewController.view.layer addSublayer:self.leftLayer];
    self.storeTypeSelectorViewController.view.transform = CGAffineTransformMakeScale(MinScale, MinScale);
    self.storeTypeSelectorViewController.view.hidden = YES;
    [self.view insertSubview:self.storeTypeSelectorViewController.view belowSubview:self.contentView];
    [self.storeTypeSelectorViewController didMoveToParentViewController:self];
    
   
    
    if (!self.storeListViewController) {
         self.storeListViewController = [WZStoreListViewController new];
        [self addChildViewController:self.storeListViewController];
        CGRect frame =  self.storeListViewController.tableView.frame;
        frame.origin.y = 40;
        frame.size.height = self.contentView.frame.size.height - 44 *2;
        self.storeListViewController.tableView.frame = frame;
         [self.contentView addSubview:self.storeListViewController.tableView];
        self.storeListViewController.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.storeListViewController didMoveToParentViewController:self];
    }
   
  
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(selectTypeForStore:)];
    [self.contentView addGestureRecognizer:panGestureRecognizer];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchMerchantListSuccess:) name:SynMerchantListSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(advertisementsDownloadSucceed:) name:WZAdvertisementsDownloadSucceedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSuccess:) name:@"locationSuccess" object:nil];
    
    
    if ([WZUser me]) {
        [WZDeleteUserMessage deleteMessagesForUser:[WZUser me]];
        
    }
    
}


//处理左右滑动
-(void)selectTypeForStore:(UIPanGestureRecognizer *)sender
{
    static CGPoint last;
    CGFloat here = self.contentView.frame.origin.x;
    if (here >0) {
        self.storeTypeSelectorViewController.view.hidden = NO;
        self.leftLayer.colors = @[(id)[UIColor colorWithWhite:0.0f alpha:MaxAlpha * (LeftMenuMaxWidth - here)/LeftMenuMaxWidth ].CGColor,(id)[UIColor colorWithWhite:0.0f alpha:MaxAlpha * (LeftMenuMaxWidth - here)/LeftMenuMaxWidth ].CGColor];
        self.storeTypeSelectorViewController.view.transform = CGAffineTransformMakeScale(1-(LeftMenuMaxWidth - here)/LeftMenuMaxWidth *(1-MinScale), 1 - (LeftMenuMaxWidth - here)/LeftMenuMaxWidth *(1-MinScale));
    }
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        last = [sender locationInView:self.view];
        self.storeTypeSelectorViewController.view.userInteractionEnabled = NO;
    }else if(sender.state == UIGestureRecognizerStateChanged){
        CGPoint now = [sender locationInView:self.view];
        CGFloat movingDistance = now.x - last.x;
        last = now;
        if (movingDistance > 0) {
            if (here <= LeftMenuMaxWidth) {
                [UIView animateWithDuration:(movingDistance * speedPixel) animations:^{
                    self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, movingDistance, 0);
                }];
            }
        }else {
            if (here > 0) {
                [UIView animateWithDuration:-movingDistance * speedPixel animations:^{
                    self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, movingDistance, 0);
                }];
            }
        }
    }else if(sender.state == UIGestureRecognizerStateEnded){
        self.storeTypeSelectorViewController.view.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = NO;
        CGFloat distance = LeftMenuMaxWidth - here;
        [UIView animateWithDuration:distance * speedPixel animations:^{
            if (here > LeftMenuMaxWidth/2) {
                self.contentView.transform = CGAffineTransformMakeTranslation(LeftMenuMaxWidth, 0);
            }else{
                self.contentView.transform = CGAffineTransformIdentity;
            }
        } completion:^(BOOL finish){
            last = CGPointZero;
             self.view.userInteractionEnabled = YES;
            if (self.contentView.frame.origin.x == 0) {
                self.storeTypeSelectorViewController.view.hidden = YES;
                self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
            }else{
                self.contentView.layer.shadowOpacity = 0.8;
                self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
                self.contentView.layer.shadowOffset = CGSizeMake(-2, -2);
                
            }
            
            CGFloat here = self.contentView.frame.origin.x;
            
            if (here > 0) {
                self.leftLayer.colors = @[(id)[UIColor colorWithWhite:0.0f alpha:MaxAlpha * (LeftMenuMaxWidth - here)/LeftMenuMaxWidth ].CGColor,(id)[UIColor colorWithWhite:0.0f alpha:MaxAlpha * (LeftMenuMaxWidth - here)/LeftMenuMaxWidth ].CGColor];
                self.storeTypeSelectorViewController.view.transform = CGAffineTransformMakeScale(1-(LeftMenuMaxWidth - here)/LeftMenuMaxWidth *(1-MinScale), 1 - (LeftMenuMaxWidth - here)/LeftMenuMaxWidth *(1-MinScale));
            }
        }];
    }
    
}

-(void)fetchMerchantListSuccess:(NSNotification *)notification
{
    [self.storeListViewController loadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect frame = self.view.frame;
    frame.origin.y = 40;
    self.view.frame = frame;
    self.contentView.backgroundColor = [UIColor redColor];
   // [self loadAdvertisements];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)locationSuccess:(NSNotification*) notification
{
    WZLocationContrl *locationControl = [WZLocationContrl sharedInstance];
    
    if(locationControl.locationKnown) {
        self.storeListViewController.here = locationControl.currentLocation;
        if (self.segmentControl.selectedSegmentIndex == 1) {
            self.storeListViewController.selectedIndex = self.segmentControl.selectedSegmentIndex;
            [self.storeListViewController sort];
        }
    }
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [self.storeListViewController didMoveToParentViewController:nil];
        [self.storeListViewController.tableView removeFromSuperview];
        [self.storeListViewController removeFromParentViewController];
        
        [self.storeTypeSelectorViewController didMoveToParentViewController:nil];
        [self.storeTypeSelectorViewController.view removeFromSuperview];
        [self.storeTypeSelectorViewController removeFromParentViewController];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:SynMerchantListSuccess object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"locationSuccess" object:nil];
        self.view = nil;
    }
}

-(IBAction)sort:(UISegmentedControl *)segmentcontrol{
    if (segmentcontrol.selectedSegmentIndex == 1) {
//        [self location];
//        self.storeListViewController.here = self.locationManager.location;
//        [self.locationManager stopUpdatingLocation];
        WZLocationContrl *locationControl = [WZLocationContrl sharedInstance];
        [locationControl start];
        if(locationControl.locationKnown) {
            self.storeListViewController.here = locationControl.currentLocation;
        }
        
    }else if (segmentcontrol.selectedSegmentIndex == 0) {
        [self updateMerchantMemberNum];
    }
    
   self.storeListViewController.selectedIndex = segmentcontrol.selectedSegmentIndex;
    [self.storeListViewController sort];
    
       
}

-(void)location
{
    if (!self.locationManager) {
        self.locationManager = [CLLocationManager new];
    }
    if ([CLLocationManager locationServicesEnabled]) {
     
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 200.0f;
        [self.locationManager startUpdatingLocation];
    }
}

-(void)updateMerchantMemberNum
{
    [WZMerchant fetchMerchantList];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"showStoreDetail" isEqualToString:segue.identifier]) {
        if ([segue.destinationViewController isKindOfClass:[WZStoreDetailViewController class]]) {
            WZStoreDetailViewController *storeDetail = (WZStoreDetailViewController *)segue.destinationViewController;
            storeDetail.store = sender;
        }
    }
}

#pragma mark -
- (IBAction)advertisements:(id)sender
{
    __block CGRect frame = _advertisementsView.frame;
    [(UIButton *)sender setEnabled:NO];
    if (_advertisementsBackground.hidden == YES) {
        _advertisementsBackground.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            frame.origin.y = 0;
            _advertisementsView.frame = frame;
        } completion:^(BOOL finished){
            [(UIButton *)sender setEnabled:YES];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            frame.origin.y = -frame.size.height;
            _advertisementsView.frame = frame;
        } completion:^(BOOL finished){
            _advertisementsBackground.hidden = YES;
            [(UIButton *)sender setEnabled:YES];
        }];
    }
}

- (void)loadAdvertisements
{
    if (!_advertisements) {
        _advertisements = [NSMutableArray new];
    }
    if (![_advertisements count]) {
        NSArray *advertisements = [WZAd allObjects];
        for (WZAd *ad in advertisements) {
            if ([ad.showFromDate timeIntervalSinceNow]>0) {
                NSString *logo = ad.postImage;
                if (logo) {
                    [_advertisements addObject:logo];
                }
            }
        }
        _advertisementsView.images = _advertisements;
      //  self.navigationItem.rightBarButtonItem = [_advertisements count]?_advertisementsItem:nil;
    }
}

- (void)reloadAdvertisements
{
    if (!_advertisements) {
        _advertisements = [NSMutableArray new];
    }
    [_advertisements removeAllObjects];
    [self loadAdvertisements];
}

- (void)advertisementsDownloadSucceed:(NSNotification *)notification
{
    NSArray *results = [[notification userInfo] objectForKey:kWZNetworkResultsKey];
    if ([results count]) {
        [self reloadAdvertisements];
    }
}
@end















