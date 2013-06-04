//
//  WZComment+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZComment+Mapping.h"
#import <RestKit/RestKit.h>
#import "WZMerchant+Mapping.h"
#import "WZUser+Mapping.h"

@implementation WZComment (Mapping)
+ (RKManagedObjectMapping *)commentMapping
{
    RKManagedObjectMapping *commentMapping = [RKManagedObjectMapping mappingForClass:[WZComment class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    commentMapping.primaryKeyAttribute = @"gid";
    [commentMapping mapKeyPathsToAttributes:@"_id",@"gid",@"merchant_id",@"merchantID",@"user_id",@"userID", nil];
    [commentMapping mapAttributes:@"content",@"rating",@"createdAt",@"commenterName", nil];
    
    
    return commentMapping;
}
@end
