//
//  WZLocationContrl.h
//  Abalone
//
//  Created by 吾在 on 13-5-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WZLocationContrl : NSObject <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocation *currentLocation;

-(void)start;
-(void)stop;
-(BOOL)locationKnown;
+(id)sharedInstance;

@end
