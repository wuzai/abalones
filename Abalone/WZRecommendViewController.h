//
//  WZRecommendViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-5.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZRecommendViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *merchantNameField;
@property (nonatomic,weak) IBOutlet UITextField *telphoneField;
- (IBAction)recomend:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)cancel:(id)sender;
@end
