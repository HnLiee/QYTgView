//
//  QYSectionHeaderView.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYSectionHeaderView.h"

#import "QYFriendsGroup.h"

static NSString *headerViewIdentifier = @"QYHeader";

@interface QYSectionHeaderView ()

@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UILabel *label;

@end

@implementation QYSectionHeaderView


+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    QYSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
    if (headerView == nil) {
        headerView = [[QYSectionHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加背景button
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bgButton];
        _bgButton = bgButton;
        
        // 设置button的属性
        // 背景图片
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        UIImage *imageHL = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        
        // 设置bgButton的背景颜色
        [bgButton setBackgroundImage:image forState:UIControlStateNormal];
        [bgButton setBackgroundImage:imageHL forState:UIControlStateHighlighted];
        // 设置bgButton的字体颜色
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置内容显示位置
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置整体内容偏移量
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置bgButton标题的偏移量
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        // 设置bgButton的图片和标题
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        // 设置button中图片视图的内容模式
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        // 超出范围是否裁剪
        bgButton.imageView.clipsToBounds = NO;
        
        [bgButton addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 在背景button右边添加label
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.textAlignment = NSTextAlignmentRight;
        _label = label;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置bgButton的frame
    _bgButton.frame = self.bounds;
    
    // 设置label的frame
    CGFloat labelW = 150;
    CGFloat labelH = self.bounds.size.height;
    CGFloat labelX = self.bounds.size.width - labelW - 10;
    CGFloat labelY = 0;
    
    _label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

- (void)bgBtnClick:(UIButton *)btn
{
    // 1.更改当前section的打开状态
    if (_friendsGroup.isOpen) {
        _friendsGroup.isOpen = NO;
    } else {
        _friendsGroup.isOpen = YES;
    }
    
    // 2.刷新表示图
    if (_headerViewClick) {
        _headerViewClick();
    }
}

// 重写setter方法，设置子视图属性
- (void)setFriendsGroup:(QYFriendsGroup *)friendsGroup
{
    _friendsGroup = friendsGroup;
    
    // 设置子视图属性
    // 设置背景button的title
    [_bgButton setTitle:friendsGroup.name forState:UIControlStateNormal];
    // 设置上线数及总数
    _label.text = [NSString stringWithFormat:@"%d/%lu",friendsGroup.online,(unsigned long)friendsGroup.friends.count];
    
    if (_friendsGroup.isOpen) {
        //_bgButton.imageView.transform = CGAffineTransformRotate(_bgButton.imageView.transform, M_PI_2);
        _bgButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        _bgButton.imageView.transform = CGAffineTransformIdentity;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
