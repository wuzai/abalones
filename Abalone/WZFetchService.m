//
//  WZFetchService.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZFetchService.h"
#import "WZUSer.h"
#import "WZMeteringCard+Mapping.h"
#import "WZMemberCard+Mapping.h"
#import "WZCoupon+Mapping.h"

NSString *const kFetchServiceSuccessNotificationKey = @"fetchServiceSuccess";
NSString *const kFetchServiceFailNotificationKey = @"fetchServiceSuccess";

@implementation WZFetchService
+ (BOOL)fetchServiceByUser:(WZUser *)user
{
   return  [[WZNetworkHelper helper] help:[self class] with:@{@"user_id":user.gid} object:nil by:RKRequestMethodGET];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}
+ (NSString *)resoucePath
{
    return @"servicesOfUser";
}
+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZUser serviceMapping];
}

+(void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kFetchServiceSuccessNotificationKey object:results];
}

+(void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kFetchServiceFailNotificationKey object:error];
}


@end
