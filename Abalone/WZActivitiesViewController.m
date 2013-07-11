//
//  WZActivitiesViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZActivitiesViewController.h"
#import "WZAdvertisementCell.h"
#import "WZAd.h"
#import "WZMerchant.h"
#import "WZAd+Logo.h"
#import "WZAdvertisementViewController.h"
#import <RestKit/RestKit.h>
#import "EGOImageView.h"
#import "HMGLTransition.h"
#import "Switch3DTransition.h"
#import "HMGLTransitionManager.h"
#import "DoorsTransition.h"
#import "ClothTransition.h"
#import "FlipTransition.h"
#import "EGOImageView.h"
#import "WZAd+Networks.h"

@interface WZActivitiesViewController ()
{
    NSMutableArray *_advertisements;
    UIImage *_cellBackgroundImage;
    WZAd *_header;
    IBOutlet EGOImageView *_headerView;
    BOOL showFlag;
}
@property (nonatomic,strong) SwipeView *swipeView;
@property (nonatomic,strong) UIPageControl *pageControl;

- (void)reload;
@end

@implementation WZActivitiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cellBackgroundImage = [[UIImage imageNamed:@"cell.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
    self.swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height -40-49)];
    self.swipeView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.swipeView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44-49-44, 320, 44)];
    [self.view addSubview:self.pageControl];
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"反转"] style:UIBarButtonItemStyleBordered target:self action:@selector(changePage:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"刷新"] style:UIBarButtonItemStyleBordered target:self action:@selector(updateAds:)];
    
    
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.wrapEnabled = NO;
    _swipeView.truncateFinalPage = YES;
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
    
    //configure page control
    _pageControl.numberOfPages = _swipeView.numberOfPages;
    _pageControl.defersCurrentPageDisplay = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAdsSuccess:) name:WZAdvertisementsDownloadSucceedNotification  object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAdsFail:) name:WZAdvertisementsDownloadFailedNotification  object:nil];
}

-(void)downloadAdsSuccess:(NSNotification *)notification
{
    [self reload];
    
    [self.swipeView reloadData];
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)self.navigationItem.leftBarButtonItem.customView;
    [activity stopAnimating];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"刷新"] style:UIBarButtonItemStyleBordered target:self action:@selector(updateAds:)];
}

-(void)downloadAdsFail:(NSNotification *)notification
{
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)self.navigationItem.leftBarButtonItem.customView;
    [activity stopAnimating];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"刷新"] style:UIBarButtonItemStyleBordered target:self action:@selector(updateAds:)];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)updateAds:(id)sender
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.frame = CGRectMake(10, 5, 30, 30);
   
    [self.navigationItem.leftBarButtonItem setCustomView:activityIndicator];
    [activityIndicator startAnimating];
    
    
    [WZAd download];
}

-(void)changePage:(id)sender
{
    [sender setEnabled:NO];
    int number = arc4random() % 4;
    HMGLTransition *animation;
    switch (number) {
        case 0:
             animation = [[DoorsTransition alloc] init];
            break;
        case 1:
            animation = [[Switch3DTransition alloc] init];
            break;
        case 2:
            animation = [[FlipTransition alloc] init];
            break;
        case 3:
            animation = [[ClothTransition alloc] init];
            break;
            
        default:
            break;
    }
    
   
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    [[HMGLTransitionManager sharedTransitionManager] beginTransition:self.view];
    
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    showFlag = !showFlag;
    if (showFlag) {
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
    
    [[HMGLTransitionManager sharedTransitionManager] commitTransition];
    
   
     [sender setEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reload];
     _pageControl.numberOfPages = _swipeView.numberOfPages;
}

#pragma mark - Reload
- (void)reload {
    if (!_advertisements) {
        _advertisements = [NSMutableArray new];
    }
    [_advertisements removeAllObjects];
    NSMutableSet *roll ;//= [NSMutableSet new];
    for (WZAd *ad in [WZAd allObjects]) {
        if ([ad.fromDate timeIntervalSinceNow]<0 && [ad.toDate timeIntervalSinceNow]>0) {
            [_advertisements addObject:ad];
            if ([ad.showToDate timeIntervalSinceNow]>0&&[ad.showFromDate timeIntervalSinceNow]<0 && ad.postImage) {
                [roll addObject:ad];
            }
        }
    }
    
    [_advertisements sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"fromDate" ascending:NO]]];
    roll = [NSSet setWithArray:_advertisements];
    _header = [roll anyObject];
    _headerView.imageURL = _header.header;
    [_tableView reloadData];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [_advertisements count];
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WZAd *ad = [_advertisements objectAtIndex:indexPath.row];
    WZAdvertisementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Advertisement"];
    cell.logoView.imageURL = ad.merchantLogo;
    cell.titleLabel.text = ad.title;
    cell.merchantLabel.text = ad.merchant.name;
    [cell.backgroundImageView setImage:_cellBackgroundImage];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WZAd *advertisement = [_advertisements objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"Advertisement" sender:advertisement];
}

#pragma mark -
- (IBAction)header:(id)sender
{
    if (_header) {
        [self performSegueWithIdentifier:@"Advertisement" sender:_header];
    }
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"Advertisement"]) {
        WZAdvertisementViewController *advertisementViewController = segue.destinationViewController;
        advertisementViewController.advertisement = sender;
    }
}


#pragma mark -swipeView delegate and dataSource
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [_advertisements count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    EGOImageView *imageView = (EGOImageView *)view;
    if (imageView == nil) {
        imageView = [[EGOImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, [UIScreen mainScreen].applicationFrame.size.height)];
       // imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        imageView.center = self.view.center;
        imageView.placeholderImage = [UIImage imageNamed:@"占位图2"];
    }
      WZAd *ad = [_advertisements objectAtIndex:index];
    imageView.imageURL =  [NSURL URLWithString: ad.postImage];
    return imageView;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    //update page control page
    _pageControl.currentPage = swipeView.currentPage;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    WZAd *advertisement = [_advertisements objectAtIndex:index];
    [self performSegueWithIdentifier:@"Advertisement" sender:advertisement];
}

- (void)pageControlTapped
{
    //update swipe view page
    [_swipeView scrollToPage:_pageControl.currentPage duration:0.4];
}


@end
