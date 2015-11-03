//
//  ResultTableViewController.m
//  团购
//
//  Created by 学不会 on 15/10/29.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "ResultTableViewController.h"

//#import "QYTableViewCell.m"
#import "QYTgCell.h"
#import "QYTgModel.h"

@interface ResultTableViewController ()

@property (nonatomic, strong) NSArray *results;

@end

@implementation ResultTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 120;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    // 搜索条件，在searchBar上
    NSString *filterStr = searchController.searchBar.text;
    
    // 如果filteredStr为nil，或者为空字符串@""
    if (!filterStr || filterStr.length == 0) {
        _results = _datas;
    } else {
        //SELF为团购的Model
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[CD] %@",filterStr];
         _results = [_datas filteredArrayUsingPredicate:predicate];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    QYTgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"QYTableViewCell" owner:self options:nil].firstObject;
    }
    
    QYTgModel *model = _results[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

@end
