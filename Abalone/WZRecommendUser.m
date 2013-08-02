//
//  WZRecommendUser.m
//  Abalone
//
//  Created by 吾在 on 13-5-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZRecommendUser.h"
#import "RKObjectMapping+Null.h"
#import "WZUser.h"

NSString *const WZRecommendUserSucceedNotification = @"WZRecommendUserSucceed";
NSString *const WZRecommendUserFailedNotification = @"WZRecommendUserFailed";

@implementation WZRecommendUser
#pragma mark -
+ (NSString *)resoucePath
{
    return @"recommendUser";
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
    [mapping mapAttributes:@"telephone",@"recommend_id",nil];
    return mapping;
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZRecommendUserSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZRecommendUserFailedNotification;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 400:
            message = @"参数错误";
            break;
        case 409:
            message = @"改用户已经注册过了";
            break;
        default:
            break;
    }
    return message;
}

#pragma mark -
+ (BOOL)recommand:(NSString *)phone by:(WZUser *)user
{
    if (phone && user) {
        return [[WZNetworkHelper helper] help:[self class] with:nil object:@{@"telephone":phone,@"recommend_id":user.gid} by:RKRequestMethodPOST];
    }
    return NO;
}


@end
