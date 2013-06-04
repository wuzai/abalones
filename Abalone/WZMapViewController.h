//
//  WZMapViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import "WZStore.h"
#import "WZLocation.h"

@interface WZMapViewController : UIViewController
<MKMapViewDelegate>

@property (strong, nonatomic)  MKMapView *myMapView;
 @property (nonatomic,strong) MyAnnotation *myAnnotation;
@property (nonatomic,strong) WZLocation *location;
@end
