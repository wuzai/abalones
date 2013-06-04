//
//  WZCoupon+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZCoupon+Mapping.h"

@implementation WZCoupon (Mapping)
+ (RKObjectMapping *)couponMapping;
{
    RKManagedObjectMapping *couponMapping = [RKManagedObjectMapping mappingForClass:[WZCoupon class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    couponMapping.primaryKeyAttribute = @"gid";
    [couponMapping mapAttributes:@"couponName",@"iconImage",@"quantity",@"point",@"allowLargess",@"allowShare",@"usableStores",@"promptIntro",@"forbidden",@"submitState",@"ruleText",  nil];
    [couponMapping mapKeyPathsToAttributes:@"_id",@"gid",@"description",@"intro", nil];
    
    return couponMapping;
}
@end
