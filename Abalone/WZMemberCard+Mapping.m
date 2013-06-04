//
//  WZMemberCard+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMemberCard+Mapping.h"

@implementation WZMemberCard (Mapping)
+ (RKObjectMapping *)memberCardMapping
{
    RKManagedObjectMapping *memberCardMapping = [RKManagedObjectMapping mappingForClass:[WZMemberCard class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    memberCardMapping.primaryKeyAttribute = @"gid";
    [memberCardMapping mapKeyPathsToAttributes:@"_id",@"gid",@"description",@"intro", nil];
    [memberCardMapping mapAttributes:@"memberCardName",@"allowLargess",@"allowShare",@"iconImage",@"usableStores",@"promptIntro",@"forbidden",@"submitState",@"ruleText", nil];
    
    
    return memberCardMapping;
}


@end
