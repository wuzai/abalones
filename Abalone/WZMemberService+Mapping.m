//
//  WZMemberService+Mapping.m
//  Abalone
//
//  Created by chen  on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMemberService+Mapping.h"

@implementation WZMemberService (Mapping)
+ (RKManagedObjectMapping *)memberServiceMapping
{
    RKManagedObjectMapping *memberMapping = [RKManagedObjectMapping mappingForClass:[WZMemberService class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    memberMapping.primaryKeyAttribute = @"gid";
    [memberMapping mapAttributes:@"memberServiceName",@"memberServiceType"
     ,@"memberServiceNumber",@"promptIntro",@"iconImage",@"vendingDate",@"validToDate",@"merchantId",@"usableStores",@"allowLargess",@"allowShare",@"usableStores",@"forbidden",@"submitState",@"ruleText",  nil];
    [memberMapping mapKeyPathsToAttributes:@"_id",@"gid",@"description",@"intro", nil];
    
    return memberMapping;
}

@end
