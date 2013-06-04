//
//  WZMerchant+Networks.h
//  Abalone
//
//  Created by 吾在 on 13-4-12.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMerchant.h"
#import "WZNetworkHelper.h"

extern  NSString * const SynMerchantListSuccess ;
extern  NSString * const SynMerchantListFail;
extern  NSString * const FetchMerchantSuccess ;
extern  NSString * const FetchMerchantFail;

@interface WZMerchant (Networks) <WZNetworkBeggar>
+ (BOOL)fetchMerchantList;
- (BOOL)fetchMerchant;
@end
