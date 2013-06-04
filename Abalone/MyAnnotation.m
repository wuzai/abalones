//
//  MyAnnotation.m
//  createAMap
//
//  Created by 吾在 on 13-5-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
-(id)initWithCoordinates:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
        _pinColor = MKPinAnnotationColorGreen;
    }
    return  self;
}

+(NSString *)reusableIdentifierForPinColor:(MKPinAnnotationColor)pinColor
{
    NSString *result = nil;
    switch (pinColor) {
        case MKPinAnnotationColorRed:
            result = REUSABLE_PIN_RED;
            break;
        case MKPinAnnotationColorGreen:
            result = REUSABLE_PIN_GREEN;
            break;
            case MKPinAnnotationColorPurple:
            result = REUSABLE_PIN_PURPLE;
            break;
        default:
            break;
    }
    return result;
}
@end



















