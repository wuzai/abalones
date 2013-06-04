//
//  WZMeteringCard+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMeteringCard+Mapping.h"

@implementation WZMeteringCard (Mapping)
+ (RKObjectMapping *)meteringCardMapping
{
    RKManagedObjectMapping *meteringCardMapping = [RKManagedObjectMapping mappingForClass:[WZMeteringCard class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    meteringCardMapping.primaryKeyAttribute = @"gid";
    [meteringCardMapping mapKeyPathsToAttributes:@"_id",@"gid",@"description",@"intro", nil];
    [meteringCardMapping mapAttributes:@"meteringCardName",@"iconImage",@"remainCount",@"vendingDate",@"validToDate",@"allowLargess",@"allowShare",@"usableStores",@"promptIntro",@"forbidden",@"submitState",@"ruleText",  nil];
    
    return meteringCardMapping;
}
@end
