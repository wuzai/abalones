//
//  WZUser.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZComment, WZConfigure, WZCoupon, WZMember, WZMemberCard, WZMemberService, WZMessage, WZMeteringCard, WZPointRecord;

@interface WZUser : NSManagedObject

@property (nonatomic, retain) NSDate * birth;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * point;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *commetns;
@property (nonatomic, retain) WZConfigure *config;
@property (nonatomic, retain) NSSet *coupons;
@property (nonatomic, retain) NSSet *memberCards;
@property (nonatomic, retain) NSSet *members;
@property (nonatomic, retain) NSSet *memberServices;
@property (nonatomic, retain) NSSet *messages;
@property (nonatomic, retain) NSSet *meteringCards;
@property (nonatomic, retain) NSSet *pointRecords;
@end

@interface WZUser (CoreDataGeneratedAccessors)

- (void)addCommetnsObject:(WZComment *)value;
- (void)removeCommetnsObject:(WZComment *)value;
- (void)addCommetns:(NSSet *)values;
- (void)removeCommetns:(NSSet *)values;

- (void)addCouponsObject:(WZCoupon *)value;
- (void)removeCouponsObject:(WZCoupon *)value;
- (void)addCoupons:(NSSet *)values;
- (void)removeCoupons:(NSSet *)values;

- (void)addMemberCardsObject:(WZMemberCard *)value;
- (void)removeMemberCardsObject:(WZMemberCard *)value;
- (void)addMemberCards:(NSSet *)values;
- (void)removeMemberCards:(NSSet *)values;

- (void)addMembersObject:(WZMember *)value;
- (void)removeMembersObject:(WZMember *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

- (void)addMemberServicesObject:(WZMemberService *)value;
- (void)removeMemberServicesObject:(WZMemberService *)value;
- (void)addMemberServices:(NSSet *)values;
- (void)removeMemberServices:(NSSet *)values;

- (void)addMessagesObject:(WZMessage *)value;
- (void)removeMessagesObject:(WZMessage *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

- (void)addMeteringCardsObject:(WZMeteringCard *)value;
- (void)removeMeteringCardsObject:(WZMeteringCard *)value;
- (void)addMeteringCards:(NSSet *)values;
- (void)removeMeteringCards:(NSSet *)values;

- (void)addPointRecordsObject:(WZPointRecord *)value;
- (void)removePointRecordsObject:(WZPointRecord *)value;
- (void)addPointRecords:(NSSet *)values;
- (void)removePointRecords:(NSSet *)values;

@end
