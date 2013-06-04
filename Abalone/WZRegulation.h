//
//  WZRegulation.h
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZRegulation : NSObject<NSCoding>
@property (nonatomic) NSArray *pictures;
@property (nonatomic,copy) NSString *rules;
+ (instancetype)defaultRegulation;
- (void)updateWithDicationary:(NSDictionary *)dicationary;
- (void)save;
@end
