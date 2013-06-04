//
//  WZRecommend.h
//  Abalone
//
//  Created by 吾在 on 13-5-5.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const WZRecommendSucceedNotification;
extern NSString *const WZRecommendFailedNotification;

@class WZUser;
@interface WZRecommend : NSObject<WZNetworkBeggar>
+ (BOOL)recommend:(NSString *)merchantName phone:(NSString *)phone by:(WZUser *)user;
@end
