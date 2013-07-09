//
//  WZMyStoresViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZFetchService.h"
#import <CoreLocation/CoreLocation.h>
#import "SDSegmentedControl.h"
#import "WZLocationContrl.h"

@interface WZMyStoresViewController : UIViewController
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UIImageView *noStoreWarnning;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addStores;

- (IBAction)addStores:(id)sender;


@end
