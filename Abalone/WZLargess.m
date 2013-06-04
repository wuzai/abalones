//
//  WZLargess.m
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZLargess.h"
#import "RKObjectMapping+Null.h"
#import "WZUser+Me.h"

 NSString *const kSendLargessSuccessNotificationKey = @"sendLargessSuccess";
 NSString *const kSendLargessFailNotificationKey = @"sendLargessFail";
@implementation WZLargess
+(BOOL)sendLargessTo:(NSString *)cellPhone withType:(NSString *)serviceType withServiceID:(NSString *)serviceID withStoreID:(NSString *)storeID
{
    if (![WZUser me]) {
        return NO;
    }
    NSDictionary *parameters = @{@"cellphone":cellPhone,@"type":serviceType,@"activity_id":serviceID,@"fromUser_id":[WZUser me].gid,@"store_id":storeID};
    return [[WZNetworkHelper helper]help:[self class] with:parameters object:nil by:RKRequestMethodGET];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}
+ (NSString *)resoucePath
{
    return @"sendLargess";
}
+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping  nullMapping];
}

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSendLargessSuccessNotificationKey object:results ];
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    NSString *errorMessage = nil;
    if (loader.response.statusCode == 404) {
        errorMessage = @"您输入的电话号码找不到相应会员";
    }else{
        errorMessage = @"转赠失败";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kSendLargessFailNotificationKey object:errorMessage ];
}



@end
