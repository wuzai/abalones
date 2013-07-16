//
//  WZConfigure+Mapping.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZConfigure+Mapping.h"

@implementation WZConfigure (Mapping)
+ (RKManagedObjectMapping *)configMapping
{
    RKManagedObjectMapping *configMapping = [RKManagedObjectMapping mappingForClass:[WZConfigure class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    configMapping.primaryKeyAttribute = @"gid";
    [configMapping mapKeyPathsToAttributes:@"_id",@"gid",
     @"pointLargessExplain",@"pointLargessExplain",@"lastUpdateTime",@"lastUpdateTime",nil];
   
    return configMapping;

}
@end
