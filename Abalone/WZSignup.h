//
//  WZSignup.h
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const WZRegisterSucceedNotification;
extern NSString *const WZRegisterFailedNotification;

@interface WZSignup : NSObject <WZNetworkBeggar>
+ (BOOL)signup:(NSString *)username withPassword:(NSString *)password andCaptcha:(NSString *)captcha;
@end
