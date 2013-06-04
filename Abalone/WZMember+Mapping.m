//
//  WZMember+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMember+Mapping.h"
#import "WZUser+Mapping.h"
#import "WZMerchant+Mapping.h"

@implementation WZMember (Mapping)
+(RKObjectMapping*)memberMapping
{
    RKManagedObjectMapping *memberMapping = [RKManagedObjectMapping mappingForClass:[WZMember class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    [memberMapping setPrimaryKeyAttribute:@"gid"];
    [memberMapping mapKeyPathsToAttributes:@"_id",@"gid",@"userId",@"userID",@"merchantId",@"merchantID",@"memberPoint", @"point",nil];
    
    [memberMapping mapAttributes:@"amount",@"createdAt", nil];
    [memberMapping  mapRelationship:@"user" withMapping:[WZUser userMapping]];
    [memberMapping  connectRelationship:@"user" withObjectForPrimaryKeyAttribute:@"userID"];
    [memberMapping  mapRelationship:@"merchant" withMapping:[WZMerchant merchntMapping]];
    [memberMapping  connectRelationship:@"merchant" withObjectForPrimaryKeyAttribute:@"merchantID"];
    
    
    return memberMapping;
}
@end
