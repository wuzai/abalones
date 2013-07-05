//
//  WZShowMyStoreDetailViewController.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-5.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZShowMyStoreDetailViewController.h"
#import "WZStore+Mine.h"
#import "WZMyStoreDetailHeaderCell.h"
#import "WZMerchant.h"
#import "WZMyStoreServiceCell.h"
#import "WZFetchService.h"
#import "WZUser+Me.h"
#import "WZMyStoreAddServiceCell.h"
#import "WZUser+Equal.h"
#import "WZSubmitCancelService.h"
#import "WZSubmitOKService.h"
#import "WZMemberCard.h"
#import "WZCoupon.h"
#import "WZMeteringCard.h"
#import <RestKit/RestKit.h>
#import "WZMyMerchantPointRecordListViewController.h"
#import "WZMyMerchantPointCell.h"
#import "WZMember.h"
#import "WZMeteringCard.h"


#define ITEM_SPACING 200

@interface WZShowMyStoreDetailViewController ()
@property (nonatomic,strong) iCarousel *carousel;
@property (nonatomic,strong) NSMutableArray *services;
@property (nonatomic,strong) WZUser *last;
@end

@implementation WZShowMyStoreDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.services = self.store.myServicesInTheStore;
    [WZFetchService fetchServiceByUser:[WZUser me]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceSuccess:) name:kFetchServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceFail:) name:kFetchServiceFailNotificationKey object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceFailNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceSuccessNotificationKey object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WZUser *user = [WZUser me];
    if (![self.last isEqualToUser:user] && self.last ) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    self.last = user;
}

-(void)fetchServiceSuccess:(NSNotification *)notification
{
    self.services = self.store.myServicesInTheStore;
    [self.carousel reloadData];
}
-(void)fetchServiceFail:(NSNotification *)notification
{
    NSLog(@"fetch services fail:%@",notification.object);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44-49)];
    [self.view addSubview:self.carousel];
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    
    self.carousel.type = iCarouselTypeCoverFlow;
    self.navigationItem.title = @"封面展示";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"展示类型" style:UIBarButtonItemStyleBordered target:self action:@selector(switchCarouselType)];
}

- (void)switchCarouselType
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"直线", @"圆圈", @"反向圆圈", @"圆桶", @"反向圆桶", @"封面展示", @"封面展示2", @"纸牌", nil];
    [sheet showInView:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    for (UIView *view in self.carousel.visibleItemViews)
    {
        view.alpha = 1.0;
    }
    
    [UIView beginAnimations:nil context:nil];
    self.carousel.type = buttonIndex;
    [UIView commitAnimations];
    
    self.navigationItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
}

#pragma mark -

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.services.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
//    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",index]]] ;
    EGOImageView *view = [[EGOImageView alloc] init];
    view.frame = CGRectMake(70, 80, 180, 260);
     id service = self.services[index];
    view.imageURL = [NSURL URLWithString:[service performSelector:@selector(iconImage)]];
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 30;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}



@end
