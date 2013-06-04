//
//  WZStoresViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-2.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZStoreListViewController.h"
#import <RestKit/RestKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SDSegmentedControl.h"
#import "WZStoreTypeSelectorViewController.h"


@interface WZStoresViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)sort:(UISegmentedControl *)segmentcontrol;
@property (weak, nonatomic) IBOutlet UIImageView *noStoresWarnning;
@property WZStoreListViewController *storeListViewController;
@property WZStoreTypeSelectorViewController *storeTypeSelectorViewController;

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (weak ,nonatomic) IBOutlet UIView *contentView;

- (IBAction)advertisements:(id)sender;
@end
