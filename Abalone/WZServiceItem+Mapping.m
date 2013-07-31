//
//  WZServiceItem+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZServiceItem+Mapping.h"
#import "WZServiceItem.h"

@implementation WZServiceItem (Mapping)
+(RKObjectMapping *)serviceItemMapping
{
    RKManagedObjectMapping *serviceItemMapping = [RKManagedObjectMapping mappingForClass:[WZServiceItem class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    serviceItemMapping.primaryKeyAttribute = @"gid";
   [serviceItemMapping mapKeyPathsToAttributes:@"_id",@"gid",@"description",@"intro",@"serviceItemName",@"serviceItemName",@"address",@"address",@"usableStores",@"usableStores",@"logoImage",@"logoImage",@"posterImage",@"posterImage",@"state",@"state", nil];
    [serviceItemMapping mapAttributes: 
    @"isRequireApply",
    @"isApplicable",
    @"allowLargess",
    @"allowShare",
    @"fromDate",
    @"toDate",
    @"serviceItemType",
     @"ruleText",
     @"promptIntro",
     @"applyExplain",
   
     nil];
    
    return serviceItemMapping;
    
}
@end
