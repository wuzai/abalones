//
//  WZNetworkScheme.h
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@protocol WZNetworkBeggar;
@interface WZNetworkScheme : NSObject
@property (nonatomic,copy) NSString *route;
@property (nonatomic) RKRequestMethod method;
@property (nonatomic,getter = isBusyNow) BOOL busy;
@property Class<WZNetworkBeggar> beggar;
@end
