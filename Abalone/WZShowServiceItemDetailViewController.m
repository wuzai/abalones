//
//  WZShowServiceItemDetailViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZShowServiceItemDetailViewController.h"
#import "WZApplyForServiceItem.h"
#import "WZUser+Me.h"
#import <QuartzCore/QuartzCore.h>

@interface WZShowServiceItemDetailViewController ()

@end

@implementation WZShowServiceItemDetailViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyServiceItemSuccess:) name:ApplyServiceItemSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyServiceItemFail:) name:ApplyServiceItemFail object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [[NSNotificationCenter defaultCenter]removeObserver:self name:ApplyServiceItemSuccess object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:ApplyServiceItemFail object:nil];
    }
}

-(void)applyServiceItemSuccess:(NSNotification *)notification
{
    self.ServiceItemapplyButton.alpha =1.0;
    self.ServiceItemapplyButton.enabled = YES;
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"申领成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

-(void)applyServiceItemFail:(NSNotification *)notification
{
    self.ServiceItemapplyButton.alpha =1.0;
    self.ServiceItemapplyButton.enabled = YES;
    NSString *message = notification.object;
    if (!message) {
        message = @"申领失败!";
    }
    [[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    self.serviceItemImageView.imageURL = [NSURL URLWithString:self.serviceItem.posterImage];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *fromDate = [formatter stringFromDate:self.serviceItem.fromDate];
    NSString *endDate = [formatter stringFromDate:self.serviceItem.toDate];
    
    self.serviceItemAddressLabel.text = self.store.address;
    self.serviceItemAddressLabel.text = [NSString stringWithFormat:@"地址:%@",self.store.address];
   // NSString *serviceItemType = nil;
    self.serviceItemNameLabel.text =self.serviceItem.serviceItemName;
    //判断服务类型
    if ([self.serviceItem.serviceItemType  isEqualToString:@"MemberCard"])
    {
        self.serviceItemTypeLabel.text = [NSString stringWithFormat:@"会员卡"];
        self.serviceItemDateLabel.hidden = true;
    }
    else if([self.serviceItem.serviceItemType isEqualToString:@"Coupon"])
    {
        self.serviceItemTypeLabel.text = [NSString stringWithFormat:@":团购活动"];
        self.serviceItemDateLabel.hidden = false;
        self.serviceItemDateLabel.text = [NSString stringWithFormat:@"%@--%@",fromDate,endDate];
    }

    if(self.serviceItem.isApplicable.boolValue == YES && self.serviceItem.isRequireApply.boolValue == YES){
        self.ServiceItemapplyButton.hidden = NO;
    }else{
        self.ServiceItemapplyButton.hidden = YES;
    }
    self.serviceItemContentTextView.text = self.serviceItem.intro;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 4.0f;
    self.contentView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.contentView.layer.borderWidth = 1.0f;
    self.serviceItemRule.text = self.serviceItem.ruleText;
    
    
    UIImage *image = self.contentbackImageView.image;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    self.contentbackImageView.image = image;
    
    image = self.addressbackImageView.image;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    self.addressbackImageView.image = image;
    
    image = self.serviceItemRulebackImageView.image;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    self.serviceItemRulebackImageView.image = image;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 220;
    }else if(indexPath.row == 1){
        CGSize size = [self.serviceItem.address sizeWithFont:self.serviceItemAddressLabel.font constrainedToSize:CGSizeMake(self.serviceItemAddressLabel.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return (size.height + 35) > 90? size.height + 35: 90;
    }else if(indexPath.row == 2){
        CGSize size = [self.serviceItem.intro sizeWithFont:self.serviceItemContentTextView.font constrainedToSize:CGSizeMake(self.serviceItemContentTextView.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
         return  MAX((size.height +25), 90);

    }else if(indexPath.row == 3){
        CGSize size = [self.serviceItem.ruleText sizeWithFont:self.serviceItemRule.font constrainedToSize:CGSizeMake(self.serviceItemRule.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return (size.height + 35) > 90? size.height + 35: 90;
    }
    
    
    
    return 0.0;
}


- (IBAction)applyServiceItem:(id)sender {
    if ([WZUser me]) {
        [WZApplyForServiceItem applyForSericeItem:self.serviceItem forUser:[WZUser me] InMerchant:self.serviceItem.merchant];
        self.ServiceItemapplyButton.alpha = 0.4;
        self.ServiceItemapplyButton.enabled = NO;
    }else{
        [self performSegueWithIdentifier:@"gotoLogin" sender:nil];
    }
}
@end
