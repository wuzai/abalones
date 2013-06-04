//
//  WZMultiImageView.h
//  MyCard
//
//  Created by 吾在 on 13-3-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZMultiImageView : UIView <UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *contentView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic) NSArray *images;
@end
