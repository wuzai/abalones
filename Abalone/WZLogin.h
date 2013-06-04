//
//  WZLogin.h
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const WZLoginSucceedNotification;
extern NSString *const WZLoginFailedNotification;

@interface WZLogin : NSObject <WZNetworkBeggar>
+ (BOOL)login:(NSString *)username withPassword:(NSString *)password;
@end
