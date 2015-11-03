//
//  QYSectionHeaderView.h
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYFriendsGroup;

@interface QYSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) QYFriendsGroup *friendsGroup;
@property (nonatomic, strong) void (^headerViewClick)();

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
