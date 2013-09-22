//
//  WZVersionAgent.m
//  Abalone
//
//  Created by 陈 海涛 on 13-9-22.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZVersionAgent.h"
#define APP_URL @"http://itunes.apple.com/lookup?id=649743732"

static WZVersionAgent *shareInstance;
@implementation WZVersionAgent

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[WZVersionAgent alloc] init];
    });
    
    return shareInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
        self.appName = [appInfo objectForKey:@"CFBundleDisplayName"];
        self.appVersion = [appInfo objectForKey:@"CFBundleVersion"];
    }
    return self;
}

- (void)checkVersionForUpdate
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:APP_URL]];
    [request setTimeoutInterval:15];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
      id obj =  [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *info = (NSDictionary *)obj;
            NSString *version = [([info  objectForKey:@"results"][0])objectForKey:@"version"];
            if (self.appVersion.doubleValue < version.doubleValue) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kupdateVersionKey];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kupdateVersionKey];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } ];
    
   
}


- (BOOL)isUpdate
{
    BOOL result = NO;
    result = [[NSUserDefaults standardUserDefaults] boolForKey:kupdateVersionKey];
   
    return result;
}

@end
