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

@interface WZActivitiesViewController ()
{
    NSMutableArray *_advertisements;
    UIImage *_cellBackgroundImage;
    WZAd *_header;
    IBOutlet EGOImageView *_headerView;
}
@property (nonatomic,strong) SwipeView *swipeView;

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
//    _switchItem = self.navigationItem.rightBarButtonItem;
	// Do any additional setup after loading the view.
    self.swipeView = [[SwipeView alloc] initWithFrame:self.view.bounds];
    self.swipeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.swipeView];
  // self.swipeView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"AlaloneBackground"]];
    self.swipeView.backgroundColor = [UIColor grayColor];
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"反转" style:UIBarButtonItemStyleBordered target:self action:@selector(changePage:)];
    
}

-(void)changePage:(id)sender
{
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
    
    [[HMGLTransitionManager sharedTransitionManager] commitTransition];
    
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
}

#pragma mark - Reload
- (void)reload {
    if (!_advertisements) {
        _advertisements = [NSMutableArray new];
    }
    [_advertisements removeAllObjects];
    NSMutableSet *roll = [NSMutableSet new];
    for (WZAd *ad in [WZAd allObjects]) {
        if ([ad.fromDate timeIntervalSinceNow]<0 && [ad.toDate timeIntervalSinceNow]>0) {
            [_advertisements addObject:ad];
            if ([ad.showToDate timeIntervalSinceNow]>0&&[ad.showFromDate timeIntervalSinceNow]<0 && ad.postImage) {
                [roll addObject:ad];
            }
        }
    }
    _header = [roll anyObject];
    [_advertisements sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"fromDate" ascending:NO]]];
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
@end
