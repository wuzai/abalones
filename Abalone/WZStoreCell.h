//
//  WZStoreCell.h
//  Abalone
//
//  Created by 吾在 on 13-4-3.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZStoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *storeImage;
@property (weak, nonatomic) IBOutlet EGOImageView *merchantLogoImage;
@property (weak, nonatomic) IBOutlet UILabel *storeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceFromHere;



@end
