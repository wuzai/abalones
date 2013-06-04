//
//  WZPointRecord+NetWorks.h
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPointRecord.h"
#import "WZNetworkHelper.h"

extern NSString *const kFetchPointRecordSuccessNotificationKey;
extern NSString *const KFetchPointRecordFailNotificationKey;

@interface WZPointRecord (NetWorks) <WZNetworkBeggar>

+(BOOL)fetchPointRecordForUserID:(NSString *)userID andMerchantID:(NSString *)merchantID withType:(NSString *)type;

@end
