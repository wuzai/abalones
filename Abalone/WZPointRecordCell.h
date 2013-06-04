//
//  WZPointRecordCell.h
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZPointRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *operateImage;
@property (weak, nonatomic) IBOutlet UILabel *recordDate;
@property (weak, nonatomic) IBOutlet UILabel *changeCount;

@property (weak, nonatomic) IBOutlet UILabel *totalPointCount;

@end
