//
//  WZServiceItem.h
//  Abalone
//
//  Created by 吾在 on 13-5-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZAd, WZMerchant;

@interface WZServiceItem : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * allowLargess;
@property (nonatomic, retain) NSNumber * allowShare;
@property (nonatomic, retain) NSDate * fromDate;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * intro;
@property (nonatomic, retain) NSNumber * isApplicable;
@property (nonatomic, retain) NSNumber * isRequireApply;
@property (nonatomic, retain) NSString * logoImage;
@property (nonatomic, retain) NSString * posterImage;
@property (nonatomic, retain) NSString * serviceItemName;
@property (nonatomic, retain) NSString * serviceItemType;
@property (nonatomic, retain) NSDate * toDate;
@property (nonatomic, retain) NSString * usableStores;
@property (nonatomic, retain) NSString * ruleText;
@property (nonatomic, retain) NSSet *ads;
@property (nonatomic, retain) WZMerchant *merchant;
@end

@interface WZServiceItem (CoreDataGeneratedAccessors)

- (void)addAdsObject:(WZAd *)value;
- (void)removeAdsObject:(WZAd *)value;
- (void)addAds:(NSSet *)values;
- (void)removeAds:(NSSet *)values;

@end
