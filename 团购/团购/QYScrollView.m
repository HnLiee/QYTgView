//
//  QYScrollView.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYScrollView.h"

@interface QYScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation QYScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
        [self addSubview:imageView];
        
        _imageView = imageView;
        
        // 设置最大最小的缩放比例
        self.maximumZoomScale = 2;
        self.minimumZoomScale = 0.5;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.delegate = self;
        
        // 添加双击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        // 设置有效点击数
        tap.numberOfTapsRequired = 2;
        
        [self addGestureRecognizer:tap];
    }
    return self;
}

// 重写setImage方法
- (void)setImage:(UIImage *)image
{
    // set方法本身要做的事
    _image = image;
    
    // set方法额外要做的事
    _imageView.image = image;
}

- (void)doubleClick:(UITapGestureRecognizer *)tap
{
    // 当前的缩放比例不为1.0，置为1.0
    if (self.zoomScale != 1.0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.zoomScale = 1.0;
        }];
        return;
    }
    
    // 当前的缩放比例为1.0的时候，放大一个指定的矩形区域
    
    // 1.先获取点击位置的中心点
    CGPoint location = [tap locationInView:self];
    // 2.求出矩形区域
    CGRect rect = CGRectMake(location.x - 100, location.y - 100, 200, 200);
    [self zoomToRect:rect animated:YES];
    
}

#pragma mark - scrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

@end
