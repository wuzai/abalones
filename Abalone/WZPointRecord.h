//
//  WZPointRecord.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZMerchant, WZStore, WZUser;

@interface WZPointRecord : NSManagedObject

@property (nonatomic, retain) NSNumber * addPoint;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * decPoint;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * merchantId;
@property (nonatomic, retain) NSString * operater;
@property (nonatomic, retain) NSString * storeId;
@property (nonatomic, retain) NSNumber * surplusPoint;
@property (nonatomic, retain) NSString * transactionType;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) WZMerchant *merchant;
@property (nonatomic, retain) WZStore *store;
@property (nonatomic, retain) WZUser *user;

@end
