//
//  WZMerchant+Networks.m
//  Abalone
//
//  Created by 吾在 on 13-4-12.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMerchant+Networks.h"
#import <RestKit/RestKit.h>
#import "WZMerchant+Mapping.h"
#import "WZStore.h"
#import "WZLocation.h"
#import "RKObjectLoader+Scheme.h"

static NSString *const kWZUpdateMerchantsTimeStamp = @"updateMerchantsTimeStamp";

NSString *const SynMerchantListSuccess = @"synMerchantListSuccess";
NSString *const SynMerchantListFail = @"synMerchantListFail";

NSString *const FetchMerchantSuccess = @"fetchMerchantSuccess";
NSString *const FetchMerchantFail = @"fetchMerchantFail";

@implementation WZMerchant (Networks)

+ (BOOL)fetchMerchantList
{
    NSDate   *timeStamp = [[NSUserDefaults standardUserDefaults] valueForKey:(NSString *)kWZUpdateMerchantsTimeStamp];
    if (!timeStamp)
    {
        timeStamp = [NSDate dateWithTimeIntervalSince1970:0];
    }
   
     return [[WZNetworkHelper helper] help:[self class] with:nil object:nil by:RKRequestMethodGET];
}

- (BOOL)fetchMerchant
{
    return  [[WZNetworkHelper helper] help:[self class] with:nil object:self by:RKRequestMethodGET];
}

#pragma mark - Beggar
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [[self class] merchntMapping];
}

+ (NSString *)resoucePath
{
    return @"merchants";
}

#pragma mark - Callbacks
+(void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    if([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET){
         [[NSNotificationCenter defaultCenter] postNotificationName:SynMerchantListSuccess  object:results];
       
    }else if(loader.method == RKRequestMethodGET){
         [[NSNotificationCenter defaultCenter] postNotificationName:FetchMerchantSuccess  object:results];
    }
}

+(void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SynMerchantListFail  object:error];
        
    }else if(loader.method == RKRequestMethodGET){
         [[NSNotificationCenter defaultCenter] postNotificationName:FetchMerchantFail  object:error];
    }
}


@end
