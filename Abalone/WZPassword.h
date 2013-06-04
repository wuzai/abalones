//
//  WZPassword.h
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const kWZOldPasswordKey;
extern NSString *const kWZNewPasswordKey;

extern NSString *const WZUpdatePasswordSucceedNotification;
extern NSString *const WZUpdatePasswordFailedNotification;

@interface WZPassword : NSObject <WZNetworkBeggar>
+ (BOOL)replace:(NSString *)oldPassword with:(NSString *)password;
@end
