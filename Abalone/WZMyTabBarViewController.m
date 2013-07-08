//
//  WZMyTabBarViewController.m
//  Abalone
//
//  Created by wz on 13-6-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMyTabBarViewController.h"

@interface WZMyTabBarViewController ()

@end

@implementation WZMyTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.view);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self addCustomTabBar];
}

-(void)addCustomTabBar
{
    NSLog(@"%@",self.view);
    self.custombg = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49, 320, 49)];
    self.custombg.backgroundColor = [UIColor clearColor];
    self.custombg.image = [UIImage imageNamed:@"customTabbar"];
    self.custombg.userInteractionEnabled = YES;
    [self.view addSubview:self.custombg];
    
    NSInteger width = 320 /4;
   
    
//    self.selectedbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 49)];
//    self.selectedbg.image = [UIImage imageNamed:@"selectedbg"];
//    [self.custombg addSubview:self.selectedbg];
//    self.selectedbg.alpha = 0.5;
    
    
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       
        button.frame = CGRectMake(i*width, 0, 80, 49);
      
        [button addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 1 ;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i",i+1]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%is",i+1]] forState:UIControlStateSelected];
      //  button.alpha = 0.8;
        [self.custombg addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
    }
}

-(void)changeSelected:(UIButton *)button
{
    self.selectedIndex = button.tag -1 ;
    NSInteger width = 320 /4;
    [UIView beginAnimations:nil context:nil];
    CGRect frame = self.selectedbg.frame;
    frame.origin.x = (button.tag -1) * width;
    self.selectedbg.frame = frame;
    [UIView commitAnimations];
    
    for (int i= 0; i<4; i++) {
        UIButton *theButton = (UIButton *)[self.custombg viewWithTag:i+1];
        if (button == theButton) {
            [theButton setSelected:YES];
        }else{
            [theButton setSelected:NO];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
