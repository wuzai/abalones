//
//  WZMerchant+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMerchant+Mapping.h"
#import "WZServiceItem+Mapping.h"
#import "WZComment+Mapping.h"

@implementation WZMerchant (Mapping)
+(RKObjectMapping *)merchntMapping
{
    
    RKManagedObjectMapping *merchantMapping = [RKManagedObjectMapping mappingForClass:[WZMerchant class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
   merchantMapping.primaryKeyAttribute = @"gid";
    [merchantMapping mapKeyPathsToAttributes:@"_id",@"gid",
    @"createdAt",@"createTime",
    @"updateAt",@"updateTime",
    @"merchantName",@"name",
    @"logoUrl",@"logo",
    @"webSite",@"url",
    @"description",@"intro",
    @"customerServicePhone",@"telphone",
     @"memberNum",@"memberNumber",
     @"point",@"score",nil];
    
    [merchantMapping mapAttributes:@"address",@"email",@"coordinate",@"image",@"explain",@"scoreState",@"comment", nil];
    
    [merchantMapping  mapRelationship:@"stores" withMapping:[WZStore storeMapping]];
    [merchantMapping mapRelationship:@"serviceItems" withMapping:[WZServiceItem serviceItemMapping]];
    [merchantMapping mapRelationship:@"comments" withMapping:[WZComment commentMapping]];
    
    return merchantMapping;
}
@end
