//
//  WZMessage+Networks.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage+Networks.h"
#import "WZMessage+Mapping.h"
#import "RKObjectMapping+Null.h"
#import "WZUser.h"
#import <RestKit/RestKit.h>

static NSString *const kUserDefaultsMessageTimeStampKey = @"WZMessageTimeStamp";

static inline NSString *messageTimeStampKey(NSString *uid)
{
    NSString *key = [NSString stringWithFormat:@"%@_%@",kUserDefaultsMessageTimeStampKey,uid];
    return key;
}

NSString *const WZDownloadMessageSucceedNotification = @"DownloadMessageSucceed";
NSString *const WZDownloadMessageFailedNotification = @"DownloadMessageFailed";

@implementation WZMessage (Networks)

#pragma mark Protocol
+ (NSString *)resoucePath
{
    return @"sendMessageRecords";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZMessage messageMapping];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping nullMapping];
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZDownloadMessageSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZDownloadMessageFailedNotification;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 400:
            message = @"参数有误";
            break;
        case 404:
            message = @"用户不存在";
            break;
        default:
            break;
    }
    return message;
}

#pragma mark - Interface
+ (BOOL)downloadMessagesForUser:(WZUser *)user
{
    if (user) {
        NSString *uid = user.gid;
        NSDate *timeStamp = [[NSUserDefaults standardUserDefaults] objectForKey:messageTimeStampKey(uid)];
        if (!timeStamp) {
            timeStamp = [NSDate dateWithTimeIntervalSince1970:0];
        }
        return [[WZNetworkHelper helper] help:[self class] with:@{kWZTimeStampKey: timeStamp, @"user_id":uid} object:nil by:RKRequestMethodGET];
    }
    return NO;
}

#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [loader.URL.queryParameters objectForKey:@"user_id"];
    [defaults setObject:[NSDate date] forKey:messageTimeStampKey(uid)];
    [defaults synchronize];
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
}

@end
