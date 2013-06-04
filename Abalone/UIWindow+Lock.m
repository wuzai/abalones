//
//  UIWindow+Lock.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "UIWindow+Lock.h"
#import "WZAppDelegate.h"
#import "WZTheme.h"

@implementation UIWindow (Lock)
+ (instancetype)mainWindow
{
    WZAppDelegate *delegete = [[UIApplication sharedApplication] delegate];
    return delegete.window;
}

+ (UIActivityIndicatorView *)waitingView
{
    static UIActivityIndicatorView *_waiting = nil;
    @synchronized (_waiting) {
        if (!_waiting) {
            _waiting = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            _waiting.color = [WZTheme themeColor];
        }
    }
    return _waiting;
}

+ (UIView *)lockView
{
    static UIView *_lock = nil;
    @synchronized (_lock) {
        if (!_lock) {
            UIWindow *window = [[self class] mainWindow];
            _lock = [[UIView alloc] initWithFrame:window.bounds];
            _lock.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
//            _lock.alpha = 0.3;
            UIActivityIndicatorView *act = [[self class] waitingView];
            [_lock addSubview:act];
            act.center = _lock.center;
        }
    }
    return _lock;
}

+ (BOOL)lock
{
    UIView *_lock = [[self class] lockView];
    UIWindow *window = [[self class] mainWindow];
    if (_lock.window != window) {
        [window addSubview:_lock];
        [[[self class] waitingView] startAnimating];
        return YES;
    }
    return NO;
}

+ (BOOL)unlock
{
    UIView *_lock = [[self class] lockView];
    if (_lock.window == [[self class] mainWindow]) {
        [[[self class] waitingView] stopAnimating];
        [_lock removeFromSuperview];
        return YES;
    }
    return NO;
}
@end
