//
//  WZMessage.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZMerchant, WZStore, WZUser;

@interface WZMessage : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * fromMerchantId;
@property (nonatomic, retain) NSString * fromStoreId;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * iconImage;
@property (nonatomic, retain) NSDate * sentTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * toID;
@property (nonatomic, retain) WZMerchant *merchant;
@property (nonatomic, retain) WZStore *store;
@property (nonatomic, retain) WZUser *to;

@end
