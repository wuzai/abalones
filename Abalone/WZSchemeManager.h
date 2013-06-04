//
//  WZSchemeManager.h
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkScheme.h"

@interface WZSchemeManager : NSObject
+ (instancetype)manager;
- (WZNetworkScheme *)schemeForRoute:(NSString *)route method:(RKRequestMethod)method;
- (BOOL)addScheme:(WZNetworkScheme *)scheme;
@end
