//
//  WZMeteringCard.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZUser;

@interface WZMeteringCard : NSManagedObject

@property (nonatomic, retain) NSNumber * allowLargess;
@property (nonatomic, retain) NSNumber * allowShare;
@property (nonatomic, retain) NSNumber * forbidden;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * iconImage;
@property (nonatomic, retain) NSString * intro;
@property (nonatomic, retain) NSString * merchantId;
@property (nonatomic, retain) NSString * meteringCardName;
@property (nonatomic, retain) NSString * promptIntro;
@property (nonatomic, retain) NSNumber * remainCount;
@property (nonatomic, retain) NSString * ruleText;
@property (nonatomic, retain) NSNumber * submitState;
@property (nonatomic, retain) NSString * usableStores;
@property (nonatomic, retain) NSDate * validToDate;
@property (nonatomic, retain) NSDate * vendingDate;
@property (nonatomic, retain) WZUser *user;

@end
