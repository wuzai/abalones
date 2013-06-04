//
//  WZMessage+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage+Mapping.h"
#import "WZUser+Mapping.h"
#import "WZMerchant+Mapping.h"
#import "WZStore+Mapping.h"

@implementation WZMessage (Mapping)
+ (RKObjectMapping *)messageMapping
{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[self class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    [mapping mapAttributes:@"title",@"content",@"iconImage",@"sentTime",@"fromMerchantId",@"fromStoreId",nil];
    [mapping mapKeyPath:@"_id" toAttribute:@"gid"];
    mapping.primaryKeyAttribute = @"gid";
    [mapping mapKeyPath:@"toUserId" toAttribute:@"toID"];
    [mapping mapRelationship:@"to" withMapping:[WZUser userMapping]];
    [mapping connectRelationship:@"to" withObjectForPrimaryKeyAttribute:@"toID"];
    [mapping mapRelationship:@"merchant" withMapping:[WZMerchant merchntMapping]];
    [mapping connectRelationship:@"merchant" withObjectForPrimaryKeyAttribute:@"fromMerchantId"];
    [mapping mapRelationship:@"store" withMapping:[WZStore storeMapping]];
    [mapping connectRelationship:@"store" withObjectForPrimaryKeyAttribute:@"fromStoreId"];
    return mapping;
}
@end
