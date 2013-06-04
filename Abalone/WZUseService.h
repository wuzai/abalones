//
//  WZUseService.h
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"
#import <RestKit/RestKit.h>

extern NSString *const kUseServiceSuccessNotificationKey;
extern NSString *const kUseServiceFailNotificationKey;

@interface WZUseService : NSObject <WZNetworkBeggar>

+(BOOL)userviceWithType:(NSString *)type forServiceID:(NSString *)serviceID inStoreID:(NSString *)storeID byUserID:(NSString *)userID;

@end
