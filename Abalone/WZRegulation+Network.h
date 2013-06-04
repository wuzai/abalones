//
//  WZRegulation+Network.h
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZRegulation.h"
#import "WZNetworkHelper.h"

//extern NSString *const WZRegulationGetSucceedNotification;
extern NSString *const WZRegulationDidUpdatedNotification;

@interface WZRegulation (Network)<WZNetworkBeggar>
+ (BOOL)updateRegulationVersion;
@end
