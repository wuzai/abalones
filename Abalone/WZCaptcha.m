//
//  WZCaptcha.m
//  Abalone
//
//  Created by 吾在 on 13-4-17.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZCaptcha.h"
#import "RKObjectMapping+Null.h"

NSString *const WZCreateCaptchaSucceedNotification = @"CreateCaptchaSucceed";
NSString *const WZCreateCaptchaFailedNotification = @"CreateCaptchaFailed";

@implementation WZCaptcha
#pragma mark - Protocol
+ (NSString *)resoucePath
{
    return @"captchaRecord";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping nullMapping];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZCreateCaptchaSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZCreateCaptchaFailedNotification;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 400:
            message = @"手机号码不正确";
            break;
        case 404:
            message = @"该号码尚未注册";
            break;
        default:
            break;
    }
    return message;
}

#pragma mark - Interface
+ (BOOL)createCaptchaFor:(NSString *)cellphone
{
    return [[WZNetworkHelper helper] help:[self class] with:@{@"cellphone":cellphone} object:nil by:RKRequestMethodGET];
}

#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
}
@end
