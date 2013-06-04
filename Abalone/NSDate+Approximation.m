//
//  NSDate+Approximation.m
//  ExproClientVIP
//
//  Created by 吾在 on 12-12-10.
//  Copyright (c) 2012年 extensivepro. All rights reserved.
//

#import "NSDate+Approximation.h"

@implementation NSDate (Approximation)
- (NSString *)approximationSinceNow
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *now = [calendar components:NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    if ([now year]==[components year]) {
        if ([now month]==[components month]) {
            NSInteger today = [now day];
            NSInteger thisDay = [components day];
            if (today-thisDay<0) {
                return @"未来";
            }
            else if (thisDay==today)
            {
                formatter.dateFormat = @"HH:mm";
            }
            else if (today-thisDay==1)
            {
                return @"昨天";
            }
            else
            {
                formatter.dateFormat = @"MM-dd";
            }
        }
        else
        {
            formatter.dateFormat = @"yyyy-MM-dd";
        }
    }
    else
    {
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    return [formatter stringFromDate:self];
}
@end
