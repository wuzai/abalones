//
//  WZAd+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAd+Mapping.h"
#import "WZMerchant+Mapping.h"
#import "WZServiceItem+Mapping.h"

@implementation WZAd (Mapping)
+ (RKObjectMapping *)advertisementMapping
{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[self class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    [mapping mapAttributes:@"title",@"postImage",@"conten",@"showFromDate",@"showToDate",@"fromDate",@"toDate",@"content",nil];
    [mapping mapKeyPath:@"_id" toAttribute:@"gid"];
    mapping.primaryKeyAttribute = @"gid";
    [mapping mapKeyPath:@"merchantId" toAttribute:@"merchantID"];
    [mapping mapRelationship:@"merchant" withMapping:[WZMerchant merchntMapping]];
    [mapping connectRelationship:@"merchant" withObjectForPrimaryKeyAttribute:@"merchantID"];
    [mapping mapRelationship:@"serviceItem" withMapping:[WZServiceItem serviceItemMapping]];
    return mapping;
}
@end
