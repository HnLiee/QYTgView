//
//  ResultTableViewController.h
//  团购
//
//  Created by 学不会 on 15/10/29.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController <UISearchResultsUpdating>

//设置搜索的数据源
@property (nonatomic, strong) NSArray *datas;

@end
