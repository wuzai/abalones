//
//  WZAppDelegate.m
//  Abalone
//
//  Created by 吾在 on 13-4-2.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAppDelegate.h"
#import "WZMerchant+Networks.h"
#import "WZUser+Me.h"
#import "WZUser+Networks.h"
#import "WZNetworkConfigure.h"
#import "WZAd+Networks.h"
#import "WZDataHub.h"
#import "WZTheme.h"
#import "WZShareSDKConfigure.h"
#import <ShareSDK/ShareSDK.h>
#import "Reachability.h"
#import "WZVersionAgent.h"



@implementation WZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WZNetworkConfigure startup];
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.5zzg.com"];
    [reachability setReachableOnWWAN:NO];
    [reachability setReachableBlock:^(Reachability * reachability){
        NSLog(@"网络可用");
        [[WZDataHub hub] startup];
    }];
    [reachability setUnreachableBlock:^(Reachability * reachability){
         NSLog(@"网络不可用");
    }];
    [reachability startNotifier];
    
    
   
    [WZTheme customize];
    [WZShareSDKConfigure sharedInit];
    
     [[WZVersionAgent shareInstance] checkVersionForUpdate];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if ([[WZVersionAgent shareInstance] isUpdate]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:3];
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.alertBody = @"贝客汇有新版本更新哦！点击到App Store升级。";
            localNotification.alertAction = @"更新";
            localNotification.soundName = nil;
            [application scheduleLocalNotification:localNotification];
        });
       
    }
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end









