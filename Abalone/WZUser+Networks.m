//
//  WZUser+Networks.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser+Networks.h"
#import "WZUser+Mapping.h"
#import "RKObjectMapping+Null.h"
#import "WZProfileModifier.h"
#import "WZMessage+Networks.h"
#import "WZRecommend.h"
#import "WZRecommendUser.h"

NSString *const WZUserProfileUpdateSucceedNotification = @"UserProfileUpdateSucceed";
NSString *const WZUserProfileUpdateFailedNotification = @"UserProfileUpdateFailed";
NSString *const WZUserProfileGetSucceedNotification = @"UserProfileGetSucceed";
NSString *const WZUserProfileGetFailedNotification = @"UserProfileGetFailed";

@implementation WZUser (Networks)

#pragma mark - Protocol
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"users";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPUT:
            return [RKObjectMapping nullMapping];
            break;
        case RKRequestMethodGET:
            return [[self class] userMapping];
        default:
            break;
    }
    return nil;
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPUT:
            return [[self class] serialMapping];
            break;
        case RKRequestMethodGET:
            return [RKObjectMapping nullMapping];
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    NSString *notificationName = nil;
    switch (method) {
        case RKRequestMethodPUT:
            notificationName = WZUserProfileUpdateSucceedNotification;
            break;
        case RKRequestMethodGET:
            notificationName = WZUserProfileGetSucceedNotification;
            break;            
        default:
            break;
    }
    return notificationName;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    NSString *notificationName = nil;
    switch (method) {
        case RKRequestMethodPUT:
            notificationName = WZUserProfileUpdateFailedNotification;
            break;
        case RKRequestMethodGET:
            notificationName = WZUserProfileGetFailedNotification;
            break;
        default:
            break;
    }
    return notificationName;
}

#pragma mark - Interface
- (BOOL)fetch
{
    return [[WZNetworkHelper helper] help:[self class] with:nil object:self by:RKRequestMethodGET];
}

- (BOOL)update
{
    NSDictionary *changes = [WZProfileModifier modifier].changes;
    if (changes) {
        NSMutableDictionary *changesWithID = [NSMutableDictionary dictionaryWithDictionary:changes];
        [changesWithID setObject:self.gid forKey:kWZGeneralIdentifierKey];
        return [[WZNetworkHelper helper] help:[self class] with:nil object:changesWithID by:RKRequestMethodPUT];
    }
    return NO;
}

- (BOOL)downloadMessages
{
    return [WZMessage downloadMessagesForUser:self];
}

- (BOOL)recommend:(NSString *)merchantName phone:(NSString *)phone
{
    return [WZRecommend recommend:merchantName phone:phone by:self];
}

- (BOOL)recommend:(NSString *)phone
{
    return [WZRecommendUser recommand:phone by:self];
}

#pragma mark - CallBacks

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    switch (loader.method) {
        case RKRequestMethodPUT: {
            [[WZProfileModifier modifier] synchronize];
        }   break;
        default:
            break;
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    switch (loader.method) {
        case RKRequestMethodPUT: {
        }   break;
        default:
            break;
    }
}
@end
