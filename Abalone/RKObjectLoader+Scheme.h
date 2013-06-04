//
//  RKObjectLoader+Scheme.h
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <RestKit/RestKit.h>

@class WZNetworkScheme;
@interface RKObjectLoader (Scheme)
@property (nonatomic,readonly) NSString *route;
@property (nonatomic,readonly) WZNetworkScheme *scheme;
@end
