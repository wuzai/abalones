//
//  WZStore+Mine.m
//  Abalone
//
//  Created by 吾在 on 13-5-4.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStore+Mine.h"
#import "WZUser+Me.h"
#import <RestKit/RestKit.h>
#import "WZMeteringCard.h"
#import "WZMemberService.h"

@implementation WZStore (Mine)
+ (NSMutableArray *)mine
{
    WZUser *user = [WZUser me];
    if (!user) {
        return  nil;
    }
    
    NSMutableArray *services = [NSMutableArray arrayWithArray:[user.memberCards allObjects]];
    [services addObjectsFromArray:user.coupons.allObjects];
    [services addObjectsFromArray:user.meteringCards.allObjects];
    [services addObjectsFromArray:user.memberServices.allObjects];
    
    NSMutableSet *storeSet = [NSMutableSet set];
    for (id obj in services) {
        if ([obj respondsToSelector:@selector(usableStores)]) {
            NSString *usableStores = [obj performSelector:@selector(usableStores)];
            NSArray *ids = [usableStores componentsSeparatedByString:@","];
            [storeSet addObjectsFromArray:ids];
        }
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"WZStore"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"gid in %@",storeSet];
    request.predicate = predicate;
    
    NSArray *stores =[WZStore executeFetchRequest:request];
    if (stores.count) {
        return [NSMutableArray arrayWithArray:stores];
    }
    
    
    return  nil;
}


- (NSMutableArray *)myServicesInTheStore
{
    WZUser *user = [WZUser me];
    if (!user) {
        return  nil;
    }
    NSMutableArray *myServices = [NSMutableArray array];
    NSMutableArray *services = [NSMutableArray arrayWithArray:[user.memberCards allObjects]];
    [services addObjectsFromArray:user.coupons.allObjects];
    
    NSMutableArray *meteringCards = [NSMutableArray arrayWithArray: user.meteringCards.allObjects];
    
    [services addObjectsFromArray:user.memberServices.allObjects];
    
    NSMutableArray *deletes = [NSMutableArray array];
    [meteringCards enumerateObjectsUsingBlock:^(id obj,NSUInteger index,BOOL *finish){
        WZMeteringCard *meteringCard = (WZMeteringCard *)obj;
        if (meteringCard.validToDate > [NSDate date]) {
            [deletes addObject:meteringCard];
        }
    }];
    [meteringCards removeObjectsInArray:deletes];
    [services addObjectsFromArray:meteringCards];
    
    for (id obj in services) {
        if ([obj respondsToSelector:@selector(usableStores)]) {
            NSString *usableStores = [obj performSelector:@selector(usableStores)];
            NSRange range = [usableStores rangeOfString:self.gid];
            if (range.location != NSNotFound) {
                if ([obj respondsToSelector:@selector(forbidden)] && [obj respondsToSelector:@selector(submitState)]) {
                    if ((![[obj performSelector:@selector(forbidden)] boolValue] && ![[obj performSelector:@selector(submitState)] boolValue])||([[obj performSelector:@selector(forbidden)] boolValue] && [[obj performSelector:@selector(submitState)] boolValue])) {
                        [myServices addObject:obj];
                    }
                }
            
            }
            
        }
    }
    
    return myServices;
}


@end








