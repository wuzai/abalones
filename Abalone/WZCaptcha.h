//
//  WZCaptcha.h
//  Abalone
//
//  Created by 吾在 on 13-4-17.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const WZCreateCaptchaSucceedNotification;
extern NSString *const WZCreateCaptchaFailedNotification;

@interface WZCaptcha : NSObject <WZNetworkBeggar>
+ (BOOL)createCaptchaFor:(NSString *)cellphone;
@end
