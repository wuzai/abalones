//
//  WZMultiImageView.m
//  MyCard
//
//  Created by 吾在 on 13-3-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMultiImageView.h"
#import "EGOImageView.h"

@interface WZMultiImageView ()
{
    NSMutableArray *_images;
    NSMutableArray *_imageViews;
}
- (void)reloadImages;
@end

@implementation WZMultiImageView
@synthesize contentView = _contentView;
@synthesize pageControl = _pageControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _images = [NSMutableArray new];
        _imageViews = [NSMutableArray new];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _images = [NSMutableArray new];
        _imageViews = [NSMutableArray new];
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    if (![_images isEqual:images]) {
        [_images removeAllObjects];
        [_images addObjectsFromArray:images];
        [self reloadImages];
    }
}

- (NSArray *)images
{
    return [_images count]?[NSArray arrayWithArray:_images]:nil;
}

- (void)reloadImages
{
    [_imageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_imageViews removeAllObjects];
    NSInteger index = 0;
    _contentView.contentSize = CGSizeMake(960, _contentView.frame.size.height);
    
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.scrollEnabled = YES;
    _contentView.delegate = self;
    _contentView.bounces = NO;
    _contentView.decelerationRate = UIScrollViewDecelerationRateFast;
    _pageControl.numberOfPages = [_images count];
    for (NSString *image in _images) {
        CGRect frame = CGRectMake(self.frame.size.width*index, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        EGOImageView *imageView = [[EGOImageView alloc] initWithFrame:frame];
        UIImage *bundleImage = [UIImage imageNamed:image];
        if (bundleImage) {
            imageView.image = bundleImage;
        }
        else {
            imageView.imageURL = [NSURL URLWithString:image];
        }
        [_contentView addSubview:imageView];
        [_imageViews addObject:imageView];
        index++;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat width = _contentView.frame.size.width;
    float r = rintf(targetContentOffset->x/width);
    targetContentOffset->x = r*width;
    _pageControl.currentPage = r;
}
@end
