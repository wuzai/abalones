//
//  WZMember.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZMerchant, WZUser;

@interface WZMember : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * merchantID;
@property (nonatomic, retain) NSNumber * point;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) WZMerchant *merchant;
@property (nonatomic, retain) WZUser *user;

@end
