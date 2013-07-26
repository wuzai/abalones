//
//  WZStore.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZLocation, WZMerchant, WZMessage, WZPointRecord;

@interface WZStore : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * cellPhone;
@property (nonatomic, retain) NSString * coordinate;
@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * rectangleImage;
@property (nonatomic, retain) NSString * slogan;
@property (nonatomic, retain) NSString * squareImage;
@property (nonatomic, retain) NSString * storeImage;
@property (nonatomic, retain) NSString * storeName;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * vipImage;
@property (nonatomic, retain) WZLocation *location;
@property (nonatomic, retain) WZMerchant *merchant;
@property (nonatomic, retain) NSSet *messages;
@property (nonatomic, retain) NSSet *pointRecords;
@end

@interface WZStore (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(WZMessage *)value;
- (void)removeMessagesObject:(WZMessage *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

- (void)addPointRecordsObject:(WZPointRecord *)value;
- (void)removePointRecordsObject:(WZPointRecord *)value;
- (void)addPointRecords:(NSSet *)values;
- (void)removePointRecords:(NSSet *)values;

@end
