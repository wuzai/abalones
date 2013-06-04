//
//  WZLargess.h
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const kSendLargessSuccessNotificationKey;
extern NSString *const kSendLargessFailNotificationKey;

@interface WZLargess : NSObject <WZNetworkBeggar>
+(BOOL)sendLargessTo:(NSString *)cellPhone withType:(NSString *)serviceType withServiceID:(NSString *) serviceID withStoreID:(NSString  *)storeID;

@end
