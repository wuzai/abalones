//
//  WZMerchantPointSendViewController.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMerchantPointSendViewController.h"

@interface WZMerchantPointSendViewController ()

@end

@implementation WZMerchantPointSendViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.sendExplain.text = self.merchant.largessExplain;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CGSize size =  [self.merchant.largessExplain sizeWithFont:self.sendExplain.font constrainedToSize:CGSizeMake(self.sendExplain.frame.size.width, 99999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height +20;
    }else{
        return 107;
    }
}


- (IBAction)sendPoint:(id)sender {
}
@end
