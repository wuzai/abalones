//
//  WZRegulation+Network.m
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZRegulation+Network.h"

//NSString *const WZRegulationGetSucceed = @"RegulationGetSucceed";
NSString *const WZRegulationDidUpdatedNotification = @"RegulationDidUpdated";
static NSString *const kWZRegulationTimeStampKey = @"RegulationTimeStamp";

@implementation WZRegulation (Network)

+ (BOOL)updateRegulationVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *timestamp = [defaults objectForKey:kWZRegulationTimeStampKey];
    if (!timestamp) {
        timestamp = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return [[WZNetworkHelper helper] help:[self class] with:@{@"timestamp": timestamp} object:nil by:RKRequestMethodGET];
    
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"regulation";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [mapping mapAttributes:@"pictures",@"rules", nil];
    return mapping;
}

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    NSDictionary *object = [results lastObject];
    if ([object count]) {
        [[[self class] defaultRegulation] updateWithDicationary:object];
        [[NSNotificationCenter defaultCenter] postNotificationName:WZRegulationDidUpdatedNotification object:nil userInfo:@{kWZNetworkLoaderKey:loader,kWZNetworkResultsKey:results}];
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
}
@end
