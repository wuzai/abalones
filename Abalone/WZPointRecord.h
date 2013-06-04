//
//  WZPointRecord.h
//  Abalone
//
//  Created by 吾在 on 13-5-16.
//  Copyright (c) 2013年 吾在. All rights reserved.
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
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) WZMerchant *merchant;
@property (nonatomic, retain) WZStore *store;
@property (nonatomic, retain) WZUser *user;

@end
