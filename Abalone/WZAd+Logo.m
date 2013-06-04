//
//  WZAd+Logo.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAd+Logo.h"
#import "WZMerchant.h"

@implementation WZAd (Logo)
- (NSURL *)header
{
    NSString *url = self.postImage;
    return url?[NSURL URLWithString:url]:nil;
}

- (NSURL *)merchantLogo
{
    NSString *url = self.merchant.logo;
    return url?[NSURL URLWithString:url]:nil;
}
@end
