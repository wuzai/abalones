//
//  WZStore+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-18.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStore+Mapping.h"
#import "WZLocation+Mapping.h"

@implementation WZStore (Mapping)
+(RKObjectMapping *)storeMapping
{
    RKManagedObjectMapping  *storeMapping = [RKManagedObjectMapping mappingForClass:[WZStore class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    storeMapping.primaryKeyAttribute =@"gid";
    [storeMapping mapKeyPathsToAttributes:@"_id",@"gid",
    @"storeName",@"storeName",
    @"address",@"address",
    @"telephone",@"cellPhone",
     @"createdAt",@"createTime",
     nil];
    [storeMapping mapAttributes:@"squareImage",@"rectangleImage",@"slogan",@"vipImage",@"type", nil];
    [storeMapping mapRelationship:@"location" withMapping:[WZLocation locationMapping]];
    
    return storeMapping;
}

@end
