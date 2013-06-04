//
//  WZResetPassword.h
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const WZResetPasswordSucceedNotification;
extern NSString *const WZResetPasswordFailedNotification;

@interface WZResetPassword : NSObject<WZNetworkBeggar>
+ (BOOL)resetPassword:(NSString *)password forUser:(NSString *)username withCaptcha:(NSString *)captcha;
@end
