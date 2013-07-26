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
    RKManagedObjectMapping *memberServiceMapping = [RKManagedObjectMapping mappingForClass:[WZMemberService class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    memberServiceMapping.primaryKeyAttribute = @"gid";
    [memberServiceMapping mapKeyPathsToAttributes:@"_id",@"gid",@"description",@"intro", nil];
    [memberServiceMapping mapAttributes:@"memberServiceName",@"memberServiceType"
     ,@"memberServiceNumber",@"promptIntro",@"iconImage",@"vendingDate",@"validToDate",@"merchantId",@"usableStores",@"allowLargess",@"allowShare",@"usableStores",@"forbidden",@"submitState",@"ruleText",  nil];
        
    return memberServiceMapping;
    

}

@end
