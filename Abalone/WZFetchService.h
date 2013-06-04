//
//  WZFetchService.h
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"
#import "WZUser.h"

extern NSString *const kFetchServiceSuccessNotificationKey ;
extern NSString *const kFetchServiceFailNotificationKey;

@interface WZFetchService : NSObject<WZNetworkBeggar>
+ (BOOL)fetchServiceByUser:(WZUser *)user;
@end
