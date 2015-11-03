//
//  GuideViewController.m
//  团购
//
//  Created by 学不会 on 15/11/1.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置scrollView的contentSize
    _scrollView.contentSize = CGSizeMake(375 * 3, 667);
    
    //分页
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置pageControl的圆点颜色
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    //创建点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
//    //设置当前手势的有效点击数
//    tap.numberOfTapsRequired = 1;
//    //把手势添加在self.view上
//    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view, typically from a nib.
}

//双击触发的方法
//-(void)doubleClick:(UITapGestureRecognizer *)tap
//{
//    NSLog(@"doubleClick");
//}

-(void)pageControlClick:(UIPageControl *)pageControl
{
    //根据当前的pageControl的currentPage更改scrollView的偏移量
    _scrollView.contentOffset = CGPointMake(375 * pageControl.currentPage, 80);
}

#pragma mark  -UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更改pageControl当前页码
    _pageControl.currentPage = scrollView.contentOffset.x/375;
    
//    for (int i = 0; i < 2; i++) {
//        if (_pageControl.currentPage == i) {
//            _button.hidden = YES;
//        }
//    }
}

@end
