//
//  WZUser+Networks.h
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser.h"
#import "WZNetworkHelper.h"

extern NSString *const WZUserProfileUpdateSucceedNotification;
extern NSString *const WZUserProfileUpdateFailedNotification;

extern NSString *const WZUserProfileGetSucceedNotification;
extern NSString *const WZUserProfileGetFailedNotification;

@interface WZUser (Networks) <WZNetworkBeggar>
- (BOOL)fetch;
- (BOOL)update;
- (BOOL)downloadMessages;
- (BOOL)recommend:(NSString *)merchantName phone:(NSString *)phone;
- (BOOL)recommend:(NSString *)phone;
@end
