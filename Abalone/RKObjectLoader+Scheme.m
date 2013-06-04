//
//  RKObjectLoader+Scheme.m
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "RKObjectLoader+Scheme.h"
#import "WZNetworkScheme.h"
#import "WZSchemeManager.h"

@implementation RKObjectLoader (Scheme)
- (NSString *)route
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.URL.path componentsSeparatedByString:@"/"]];
    [array removeObjectsInRange:NSMakeRange(0, 3)];
    return [array componentsJoinedByString:@"/"];
}

- (WZNetworkScheme *)scheme
{
    return [[WZSchemeManager manager] schemeForRoute:self.route method:self.method];
}
@end
