//
//  WZAd.h
//  Abalone
//
//  Created by 吾在 on 13-5-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZMerchant, WZServiceItem;

@interface WZAd : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * fromDate;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * merchantID;
@property (nonatomic, retain) NSString * postImage;
@property (nonatomic, retain) NSDate * showFromDate;
@property (nonatomic, retain) NSDate * showToDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * toDate;
@property (nonatomic, retain) WZMerchant *merchant;
@property (nonatomic, retain) WZServiceItem *serviceItem;

@end
