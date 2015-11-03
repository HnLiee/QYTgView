//
//  QYTableViewCell.h
//  团购
//
//  Created by 学不会 on 15/11/1.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYTgModel;

@interface QYTableViewCell : UITableViewCell

@property (nonatomic, strong) QYTgModel *model;

@end
