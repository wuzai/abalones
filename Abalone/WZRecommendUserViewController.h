//
//  WZRecommendUserViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZRecommendUserViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *telphoneField;
- (IBAction)recomend:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)cancel:(id)sender;
@end
