//
//  WZMapViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMapViewController.h"


@interface WZMapViewController ()

@end

@implementation WZMapViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    self.myMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    /*
     enum {
     MKMapTypeStandard = 0, 标准地图
     MKMapTypeSatellite,    卫星图
     MKMapTypeHybrid        混合地图
     };
     */
    self.myMapView.mapType = MKMapTypeStandard;
    self.myMapView.delegate = self;
    self.myMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.myMapView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        self.myMapView = nil;
    }
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *result = nil;
    if (![annotation isKindOfClass:[MyAnnotation class]]) {
        return result;
    }
    if (![mapView isEqual:self.myMapView]) {
        return  result;
    }
    
    MyAnnotation *myAnnotation = (MyAnnotation *)annotation;
    NSString *pinReusableIdentifier = [MyAnnotation reusableIdentifierForPinColor:myAnnotation.pinColor];
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:pinReusableIdentifier];
        [annotationView setCanShowCallout:YES];
    }
    annotationView.pinColor = myAnnotation.pinColor;
    UIImage *pinImage = [UIImage imageNamed:@"BluePin"];
    if (pinImage) {
        annotationView.image = pinImage;
    }
    
    result = annotationView;
    return result;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.location.latitude.doubleValue,self.location.longitude.doubleValue);
    self.myAnnotation =  [[MyAnnotation alloc] initWithCoordinates:coordinate title:self.location.relevantText subtitle:@""];
    self.myAnnotation.pinColor = MKPinAnnotationColorPurple;
    
    [self.myMapView addAnnotation:self.myAnnotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate,2000, 2000);
    region = [self.myMapView regionThatFits:region];
    [self.myMapView setRegion:region animated:YES];
}

@end
