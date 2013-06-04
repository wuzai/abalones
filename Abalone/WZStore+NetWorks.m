//
//  WZStore+NetWorks.m
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStore+NetWorks.h"
#import "WZStore+Mapping.h"
#import "RKObjectLoader+Scheme.h"

@implementation WZStore (NetWorks)
- (BOOL)fetchStore
{
     return  [[WZNetworkHelper helper] help:[self class] with:nil object:self by:RKRequestMethodGET];
}

#pragma mark - Beggar
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [[self class] storeMapping];
}

+ (NSString *)resoucePath
{
    return @"stores";
}

#pragma mark - Callbacks

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
       
    }else if(loader.method == RKRequestMethodGET){
        
    }
    
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
       
        
    }else if(loader.method == RKRequestMethodGET){
        
    }
    
}
@end
