//
//  WZPointRecord+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPointRecord+Mapping.h"
#import "WZStore+Mapping.h"
#import "WZUser+Mapping.h"
#import "WZMerchant+Mapping.h"

@implementation WZPointRecord (Mapping)
+(RKObjectMapping *)pointRecordMapping
{
    RKManagedObjectMapping *pointRecordMapping = [RKManagedObjectMapping mappingForEntityWithName:@"WZPointRecord" inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    pointRecordMapping.primaryKeyAttribute  = @"gid";
    [pointRecordMapping mapKeyPathsToAttributes:@"_id",@"gid", nil];
    [pointRecordMapping mapAttributes:@"userId",@"merchantId",@"transcationType",@"addPoint",@"decPoint",@"surplusPoint",@"operater",@"storeId",@"createdAt",@"type", nil];
    
    [pointRecordMapping mapRelationship:@"store" withMapping:[WZStore storeMapping]];
    [pointRecordMapping connectRelationship:@"store" withObjectForPrimaryKeyAttribute:@"storeId"];
    
    [pointRecordMapping mapRelationship:@"user" withMapping:[WZUser userMapping]];
    [pointRecordMapping connectRelationship:@"user" withObjectForPrimaryKeyAttribute:@"userId"];
    
    [pointRecordMapping mapRelationship:@"merchant" withMapping:[WZMerchant merchntMapping]];
    [pointRecordMapping connectRelationship:@"merchant" withObjectForPrimaryKeyAttribute:@"merchantId"];
    
    return pointRecordMapping;
}
@end
