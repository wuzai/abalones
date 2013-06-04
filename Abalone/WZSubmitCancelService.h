//
//  WZSubmitCancelService.h
//  Abalone
//
//  Created by 吾在 on 13-5-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h" 

extern NSString *const kSubmitCancelServiceSuccessNotificationKey;
extern NSString *const kSubmitCancelServiceFailNotificationKey;
@interface WZSubmitCancelService : NSObject <WZNetworkBeggar>

+(BOOL)submitCancelForLargessServiceID:(NSString *)serviceID withType:(NSString *)serviceType byUserID:(NSString *)userID withStoreID:(NSString  *)storeID;

@end
