//
//  WZCityView.m
//  Abalone
//
//  Created by 陈 海涛 on 13-9-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZCityView.h"
#import "WZStoresViewController.h"
#import "JWFolders.h"

@implementation WZCityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"CityView" owner:self options:nil] lastObject];
        [self addSubview:view];
        self.frame = view.frame;
        
      NSString *city =  [[NSUserDefaults standardUserDefaults] stringForKey:kCity];
        if (city == nil) {
            city = @"北京";
        }
        for (UIButton *button in self.citys) {
            if ([button.titleLabel.text isEqualToString:city]) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
            button.showsTouchWhenHighlighted = YES;
        }
        
    }
    return self;
}

- (void)selectCity:(UIButton *)button
{
    [[NSUserDefaults standardUserDefaults] setValue:button.titleLabel.text forKey:kCity];
    NSString *city =  button.titleLabel.text;
    for (UIButton *button in self.citys) {
        if ([button.titleLabel.text isEqualToString:city]) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
       
    }
[self.sVC.floder closeCurrentFolder];
    UIButton *rightButton =(UIButton *)self.sVC.navigationItem.rightBarButtonItem.customView;
[rightButton setTitle:city forState:UIControlStateNormal];
}

@end
