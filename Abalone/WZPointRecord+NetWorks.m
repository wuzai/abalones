//
//  WZPointRecord+NetWorks.m
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPointRecord+NetWorks.h"
#import "WZPointRecord+Mapping.h"

NSString *const kFetchPointRecordSuccessNotificationKey = @"fetchPointRecordSuccess";
NSString *const KFetchPointRecordFailNotificationKey = @"fetchPointRecordFail";

@implementation WZPointRecord (NetWorks)

+(BOOL)fetchPointRecordForUserID:(NSString *)userID andMerchantID:(NSString *)merchantID withType:(NSString *)type
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"user_id":userID,@"type":type}];
    if (merchantID) {
        [dic setObject:merchantID forKey:@"merchant_id"];
    }
    return [[WZNetworkHelper  helper] help:[self class] with:dic object:nil by:RKRequestMethodGET];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"pointRecords";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZPointRecord pointRecordMapping];
}

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kFetchPointRecordSuccessNotificationKey object:results];
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KFetchPointRecordFailNotificationKey object:error];
}
@end
