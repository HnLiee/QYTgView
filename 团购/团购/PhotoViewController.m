//
//  PhotoViewController.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "PhotoViewController.h"

#import "QYScrollView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface PhotoViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建并添加滚动的底部ScrollView
    [self addScrollView];
    
    // 在底部的ScrollView上添加缩放的ScrollView
    [self addSubViewForScrollView];
}

- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW + 25, kScreenH)];
    [self.view addSubview:scrollView];
    
    // contentSize
    scrollView.contentSize = CGSizeMake((kScreenW + 25) * 3, kScreenH);
    // 翻页
    scrollView.pagingEnabled = YES;
    // 滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    scrollView.backgroundColor = [UIColor blackColor];
    
    _scrollView = scrollView;
}

- (void)addSubViewForScrollView
{
    for (int i = 0; i < 3; i++) {
        QYScrollView *QYView = [[QYScrollView alloc] initWithFrame:CGRectMake((kScreenW + 25) * i, 64, kScreenW, kScreenH)];
        [_scrollView addSubview:QYView];
        
        // 方法
        //[QYView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i + 1]]];
        // 属性
        QYView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i + 1]];
        
        //        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW + 25) * i, 0, kScreenW, kScreenH)];
        //        [_scrollView addSubview:imageView];
        //
        //        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i + 1]];
    }
}

#pragma mark - scrollView delegate

// 减速完成,把上个界面缩放的ScrollView的缩放比例设置为1，0
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (QYScrollView *QYView in scrollView.subviews) {
        //判断scroll对象是否是QYScrollView类型的
        if ([QYView isKindOfClass:[QYScrollView class]]) {
            QYScrollView *qyScrollView = (QYScrollView *)QYView;
            //设置缩放比例
            qyScrollView.zoomScale = 1.0;
        }
        
    }
}

@end
