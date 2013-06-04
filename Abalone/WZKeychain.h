//
//  WZKeychain.h
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZKeychain : NSObject
@property (readonly) NSString *username;
@property (readonly) NSString *password;
+ (instancetype)keychain;
- (void)prepareForUsername:(NSString *)username password:(NSString *)password;
- (void)synchronize;
- (void)invalid;
@end
