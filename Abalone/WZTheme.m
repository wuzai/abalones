//
//  WZTheme.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZTheme.h"
#import "WZAppDelegate.h"

@implementation WZTheme
+ (UIColor *)themeColor
{
    static UIColor *_themeColor = nil;
    @synchronized (_themeColor) {
        if (!_themeColor) {
            _themeColor = [UIColor colorWithRed:84.0/255.0 green:77.0/255.0 blue:84.0/255.0 alpha:1.0];
//            [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
        }
    }
    return _themeColor;
}

+ (UIColor *)backColor
{
    static UIColor *_backColor = nil;
    @synchronized (_backColor) {
        if (!_backColor) {
            _backColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"AlaloneBackground"]];
           // [self.view setBackgroundColor:bgColor];
           // _backColor = [UIColor colorWithWhite:0.85 alpha:1];
        }
    }
    return _backColor;
}

+ (void)customize
{
//    WZAppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    UITabBarController *tarBarController = (UITabBarController *)delegate.window.rootViewController;
//    for (UITabBarItem *item in tarBarController.tabBar.items) {
//        NSString *title = item.title;
//        UIImage *selected = [UIImage imageNamed:[NSString stringWithFormat:@"%@302.png",title]];
//        UIImage *unselected = [UIImage imageNamed:[NSString stringWithFormat:@"%@301.png",title]];
//        [item setFinishedSelectedImage:selected withFinishedUnselectedImage:unselected];
//    }
    [[UINavigationBar appearance] setTintColor:[[self class] themeColor]];
    
    UIImage *image = [UIImage imageNamed:@"导航栏.png"];
    if ([UIDevice currentDevice].systemVersion.intValue > 6) {
        image = [UIImage imageNamed:@"导航栏7.png"];
    }
    
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"TabBar.png"]];
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"TabBarIndicator.png"]];
    [[UITableView appearance] setBackgroundColor:[[self class] backColor]];
    [[UITableView appearance] setSeparatorColor:[UIColor lightGrayColor]];
}
@end
