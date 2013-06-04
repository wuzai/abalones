//
//  NSString+Format.h
//  MyCard
//
//  Created by 吾在 on 13-3-20.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)
@property (nonatomic,readonly,getter = isValidTelphone) BOOL validTelphone;
@property (nonatomic,readonly,getter = isValidCaptcha) BOOL validCaptcha;
@property (nonatomic,readonly,getter = isValidPassword) BOOL validPassword;
@property (nonatomic,readonly,getter = isValidEmail) BOOL validEmail;
@end
