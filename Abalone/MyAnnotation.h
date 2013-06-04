//
//  MyAnnotation.h
//  createAMap
//
//  Created by 吾在 on 13-5-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define REUSABLE_PIN_RED @"Red"
#define REUSABLE_PIN_GREEN @"Green"
#define REUSABLE_PIN_PURPLE @"Purple"

@interface MyAnnotation : NSObject <MKAnnotation>
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,readonly,copy) NSString *title;
@property (nonatomic,readonly,copy) NSString *subtitle;
@property (nonatomic,unsafe_unretained) MKPinAnnotationColor pinColor;

-(id)initWithCoordinates:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

+(NSString *)reusableIdentifierForPinColor:(MKPinAnnotationColor)pinColor;
@end
















