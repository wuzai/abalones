//
//  WZRecommendUser.h
//  Abalone
//
//  Created by 吾在 on 13-5-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const WZRecommendUserSucceedNotification;
extern NSString *const WZRecommendUserFailedNotification;

@class WZUser;
@interface WZRecommendUser : NSObject<WZNetworkBeggar>
+ (BOOL)recommand:(NSString *)phone by:(WZUser *)user;
@end
