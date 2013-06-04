//
//  WZRecommend.m
//  Abalone
//
//  Created by 吾在 on 13-5-5.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZRecommend.h"
#import "RKObjectMapping+Null.h"
#import "WZUser.h"

NSString *const WZRecommendSucceedNotification = @"WZRecommendSucceed";
NSString *const WZRecommendFailedNotification = @"WZRecommendFailed";

@implementation WZRecommend
#pragma mark -
+ (NSString *)resoucePath
{
    return @"recommend";
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping nullMapping];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"merchantName",@"telephone",@"recommend_id",nil];
    return mapping;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 400:
            message = @"参数错误";
            break;
        default:
            break;
    }
    return message;
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZRecommendSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZRecommendFailedNotification;
}

#pragma mark -
+ (BOOL)recommend:(NSString *)merchantName phone:(NSString *)phone by:(WZUser *)user
{
    if (merchantName && phone && user) {
       return [[WZNetworkHelper helper] help:[self class] with:nil object:@{@"merchantName":merchantName,@"telephone":phone,@"recommend_id":user.gid} by:RKRequestMethodPOST];
    }
    return NO;
}

@end
