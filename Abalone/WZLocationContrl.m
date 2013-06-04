//
//  WZLocationContrl.m
//  Abalone
//
//  Created by 吾在 on 13-5-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZLocationContrl.h"
@interface WZLocationContrl ()
@property (nonatomic,strong) CLLocationManager *locationManager;


@end

static WZLocationContrl *sharedInstance;

@implementation WZLocationContrl
@synthesize currentLocation;
@synthesize locationManager;

+(id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WZLocationContrl alloc] init];
    });
    
    return sharedInstance;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.locationManager =  [CLLocationManager new];
        self.locationManager.delegate = self;
        if ([CLLocationManager locationServicesEnabled]) {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.distanceFilter = 200.0f;
            [self.locationManager startUpdatingLocation];
        }
    }
    return self;
}

-(void)start
{
    [self.locationManager startUpdatingLocation];
}

-(void)stop
{
    [self.locationManager stopUpdatingLocation];
}

-(BOOL)locationKnown
{
    if (self.currentLocation == nil) {
        return NO;
    }else{
        return YES;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    if (abs([newLocation.timestamp timeIntervalSinceNow]) < 5) {
        [self stop];
        self.currentLocation = newLocation;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"locationSuccess" object:newLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stop];
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end






















