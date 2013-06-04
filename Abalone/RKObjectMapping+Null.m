//
//  RKObjectMapping+Null.m
//  Abalone
//
//  Created by 吾在 on 13-4-17.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "RKObjectMapping+Null.h"
static RKObjectMapping *_null = nil;

@implementation RKObjectMapping (Null)
+ (instancetype)nullMapping
{
    if (!_null) {
        _null = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    }
    return _null;
}
@end
