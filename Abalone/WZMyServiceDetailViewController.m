//
//  WZMyServiceDetailViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMyServiceDetailViewController.h"
#import "WZMeteringCard.h"
#import "WZMemberCard.h"
#import "WZCoupon.h"
#import "WZUser+Me.h"
#import "WZUser+Equal.h"
#import "WZServiceItem.h"
#import "WZMemberService.h"

@interface WZMyServiceDetailViewController ()
@property (nonatomic,strong)NSString *servicetitle;
@property (nonatomic,strong)NSString *promtMessage;
@property (nonatomic,strong)NSString *intro;
@property (nonatomic,strong)WZUser *last;
@property (nonatomic,strong)NSString *serviceRuleText;
@end

@implementation WZMyServiceDetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WZUser *user = [WZUser me];
    if (![self.last isEqualToUser:user] && self.last ) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    self.last = user;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)loadData
{
    if ([self.service isKindOfClass:[WZCoupon class]]) {
        WZCoupon *coupon = (WZCoupon *)self.service;
        self.serviceTitle.text = coupon.couponName;
        self.servicePromptMessage.text  = coupon.promptIntro;
        self.serviceDescription.text = coupon.intro;
        self.servicetitle = coupon.couponName;
        self.promtMessage = coupon.promptIntro;
        self.intro = coupon.intro;
        self.serviceImageView.imageURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@",coupon.iconImage]];
        self.serviceRule.text = coupon.ruleText;
        self.serviceRuleText = coupon.ruleText;
    }else if([self.service isKindOfClass:[WZMemberCard class]]){
        WZMemberCard *memberCard = (WZMemberCard *)self.service;
        self.serviceTitle.text = memberCard.memberCardName;
        self.servicePromptMessage.text = memberCard.promptIntro;
        self.serviceDescription.text = memberCard.intro;
        self.servicetitle = memberCard.memberCardName;
        self.promtMessage = memberCard.promptIntro;
        self.intro = memberCard.intro;
         self.serviceImageView.imageURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@",memberCard.iconImage]];
        self.serviceRule.text = memberCard.ruleText;
        self.serviceRuleText = memberCard.ruleText;
    }else if([self.service isKindOfClass:[WZMeteringCard class]]){
        WZMeteringCard *meteringCard = (WZMeteringCard *)self.service;
        self.serviceTitle.text = meteringCard.meteringCardName;
        //使用说明
        self.servicePromptMessage.text  = meteringCard.ruleText;
        //服务描述
        self.serviceDescription.text = meteringCard.intro;
        self.servicetitle = meteringCard.meteringCardName;
        self.promtMessage = meteringCard.promptIntro;
        self.intro = meteringCard.intro;
         self.serviceImageView.imageURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@",meteringCard.iconImage]];
        self.serviceRule.text = meteringCard.ruleText;
        self.serviceRuleText = meteringCard.ruleText;
    }
    else if ([self.service isKindOfClass:[WZMemberService class]])//扩展类型
    {
        WZMemberService *serviceItem = (WZMemberService *)self.service;
        self.serviceTitle.text = serviceItem.memberServiceName;
        //使用说明
        self.serviceRule.text  = serviceItem.ruleText;
        //服务描述
        self.serviceDescription.text = serviceItem.intro;
        
        self.intro = serviceItem.intro;
        self.serviceImageView.imageURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@",serviceItem.iconImage]];
    }    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            
        case 0:
            return 180;
            break;
            //        case 2:   //服务详情
            //            return [self heightForLabel:self withString:self.promtMessage];
            //            break;
        case 2:
            return [self heightForLabel:self.serviceDescription withString:self.intro];
            break;
        case 1:   //使用说明
            return [self heightForLabel:self.serviceRule  withString:self.serviceRuleText];
            break;
        default:
            break;
    }
    return 0.0;
}


-(CGFloat)heightForLabel:(UILabel *)label withString:(NSString *)str
{
    if (!str) {
        return 44;
    }
    CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 10 >44 ? size.height + 10 : 44;
}


- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIImage *image = [UIImage imageNamed:@"使用说明"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        return imageView;
    }else if(section == 2){
        UIImage *image = [UIImage imageNamed:@"服务详情"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        return imageView;
        
    }
//    else if(section == 3){
//        UIImage *image = [UIImage imageNamed:@"温馨提示"];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        return imageView;
//        
//    }
    return nil;
}

@end







