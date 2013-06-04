//
//  WZStore+AllTypes.m
//  Abalone
//
//  Created by 吾在 on 13-5-29.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStore+AllTypes.h"
#import <RestKit/RestKit.h>

@implementation WZStore (AllTypes)
+(NSArray *)allTypes
{
    NSMutableSet *set = [NSMutableSet set];
    NSArray *stores = [WZStore allObjects];
    [stores enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
        WZStore *store = (WZStore *)obj;
        if (store.type) {
            [set addObject:store.type];
        }else{
            [set addObject:store.storeName];
        }
     
    }];
    if (set.count) {
        [set addObject:@"所有类型"];
        return [set allObjects];
    }else{
        return nil;
    }
}
@end
