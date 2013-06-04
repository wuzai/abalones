//
//  WZNetworkHelper.h
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

extern NSString *kWZNetworkLoaderKey;
extern NSString *kWZNetworkResultsKey;
extern NSString *kWZNetworkErrorKey;

extern NSString *kWZGeneralIdentifierKey;
extern NSString *kWZTimeStampKey;

@protocol WZNetworkBeggar <NSObject>
@required
+ (RKObjectManager *)manager;
+ (NSString *)resoucePath;
+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method;
@optional
+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method;
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results;
+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error;
+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method;
+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method;
+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method;
@end

@interface WZNetworkHelper : NSObject
+ (instancetype)helper;
- (BOOL)help:(Class<WZNetworkBeggar>)begger with:(NSDictionary *)query object:(id)object by:(RKRequestMethod)method;
@end
