//
//  WZMember.h
//  Abalone
//
//  Created by 吾在 on 13-5-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
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
