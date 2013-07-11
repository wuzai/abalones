//
//  WZUser+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser+Mapping.h"
#import "WZMemberCard+Mapping.h"
#import "WZCoupon+Mapping.h"
#import "WZMeteringCard+Mapping.h"
#import "WZMember+Mapping.h"

@implementation WZUser (Mapping)
+ (RKObjectMapping *)userMapping
{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[WZUser class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
     mapping.primaryKeyAttribute = @"gid";
    [mapping mapKeyPath:@"_id" toAttribute:@"gid"];
    [mapping mapKeyPath:@"userName" toAttribute:@"username"];
    [mapping mapAttributes:@"gender",@"name",@"email",@"point",@"birth", nil];
    
   
    return mapping;
}

+ (RKObjectMapping *)registerMapping
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"username",@"password",@"captcha", nil];
    return mapping;
}

+ (RKObjectMapping *)serialMapping
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"gender",@"name",@"email",@"birth", nil];
    return mapping;
}

+ (RKObjectMapping *)serviceMapping
{
    RKManagedObjectMapping *userMapping = [RKManagedObjectMapping mappingForClass:[WZUser class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    userMapping.primaryKeyAttribute = @"gid";
    [userMapping mapKeyPathsToAttributes:@"_id",@"gid",@"userName",@"username", nil];
    
    [userMapping mapRelationship:@"memberCards"  withMapping:[WZMemberCard memberCardMapping]];
    [userMapping mapRelationship:@"coupons" withMapping:[WZCoupon couponMapping]];
    [userMapping mapRelationship:@"meteringCards" withMapping:[WZMeteringCard meteringCardMapping]];
    [userMapping mapRelationship:@"members" withMapping:[WZMember memberMapping]];
    
    return userMapping;
}



@end
