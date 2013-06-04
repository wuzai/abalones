//
//  WZAddCommentViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMerchant.h"

@interface WZAddCommentViewController : UIViewController <UITextViewDelegate>
@property (nonatomic,strong)WZMerchant *merchant;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordNum;
- (IBAction)sendComment:(id)sender;


@end
