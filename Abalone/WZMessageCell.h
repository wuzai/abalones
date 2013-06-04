//
//  WZMessageCell.h
//  Abalone
//
//  Created by 吾在 on 13-4-2.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZMessageCell : UITableViewCell
@property (nonatomic,weak) IBOutlet EGOImageView *logoView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
//@property (nonatomic,weak) IBOutlet UITextView *detailView;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *dateLabel;
@property (nonatomic,weak) IBOutlet UIButton *merchantButton;
@property (nonatomic,weak) IBOutlet UIImageView *backgroundImageView;
@end
