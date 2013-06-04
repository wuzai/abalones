//
//  WZStore+serviceItems.m
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStore+serviceItems.h"
#import <RestKit/RestKit.h>
#import "WZServiceItem.h"

@implementation WZStore (serviceItems)
-(NSMutableArray *)serviceItems
{
    NSMutableArray *deleteArray = [NSMutableArray array];
    NSMutableArray *serviceItems = [NSMutableArray arrayWithArray:[WZServiceItem findAll]];
    for (WZServiceItem *serviceItem in serviceItems) {
       NSRange range = [serviceItem.usableStores rangeOfString:self.gid];
        if (range.location == NSNotFound) {
            [deleteArray addObject:serviceItem];
        }
    }
    if (deleteArray.count) {
        [serviceItems removeObjectsInArray:deleteArray];
    }
    NSLog(@"serviceItem:%@",serviceItems);
    return serviceItems;
}
@end
