//
//  LOlViewController.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "LOlViewController.h"

#import "QYFriendsGroup.h"
#import "QYFriends.h"

#import "QYSectionHeaderView.h"

static NSString *identifier = @"LOL";

@interface LOlViewController () <UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchFriends;
@property (nonatomic) BOOL isSearching;

@end

@implementation LOlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSearchBarForTableHeaderView];
    //[self groups];
}

// 在头视图上添加搜索框
- (void)setSearchBarForTableHeaderView
{
    // 把所搜结果显示在同一个View上，在初始化的事后传nil
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
    // 设置更新结果的代理
    _searchController.searchResultsUpdater = self;
    
    self.tableView.tableHeaderView = _searchController.searchBar;
}

- (NSArray *)groups
{
    if (_groups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hero" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *groupModels = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYFriendsGroup *friendsGroup = [QYFriendsGroup groupWithDictionary:dict];
            [groupModels addObject:friendsGroup];
        }
        _groups = groupModels;
        _searchFriends = _groups;
    }
    return _groups;
}
- (IBAction)edit:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"编辑"]) {
        [_tableView setEditing:YES animated:YES];
        sender.title = @"完成";
    } else {
        [_tableView setEditing:NO animated:YES];
        sender.title = @"编辑";
    }
}

#pragma mark - UITableViewDataSource

// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 查找的时候
    if (_isSearching) {
        return 1;
    }
    return self.groups.count;
}

// 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 查找的时候
    if (_isSearching) {
        return _searchFriends.count;
    }
    
    QYFriendsGroup *group = self.groups[section];
    if ([group isOpen]) {
        return group.friends.count;
    } else {
        return 0;
    }
}

// 每行单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    
    QYFriends *friend = nil;
    
    if (_isSearching) {
        friend = _searchFriends[indexPath.row];
    } else {
        QYFriendsGroup *friendGroup = self.groups[indexPath.section];
        friend = friendGroup.friends[indexPath.row];
    }
    
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.intro;
    
    cell.textLabel.textColor = friend.vip ? [UIColor redColor]:[UIColor blackColor];
    
    return cell;
}

// 设置sectionHeaderView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSearching) {
        return 0;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_isSearching) {
        return nil;
    }
    // 创建sectionHeaderView(已经复用)
    QYSectionHeaderView *sectionHeaderView = [QYSectionHeaderView headerViewWithTableView:tableView];
    
    // 取出当前section对应的数据模型QYFriendsGroup
    QYFriendsGroup *fg = self.groups[section];
    sectionHeaderView.friendsGroup = fg;
    
    sectionHeaderView.headerViewClick = ^(){
        [tableView reloadData];
    };
    
    return sectionHeaderView;
}

// 编辑 (增加,删除,移动)
// 是否允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 指定当前编辑的风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return UITableViewCellEditingStyleDelete;
}

// 提交编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // ⚠️⚠️⚠️⚠️⚠️ QYFriendsGroup 的 friends属性必须是可变的
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        QYFriendsGroup *friendsGroup = self.groups[indexPath.section];
        [friendsGroup.friends removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// 是否移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 找到要移动的数据所属的组
    QYFriendsGroup *sourceFriendsGroup = self.groups[sourceIndexPath.section];
    // 找到要移动的数据
    QYFriends *friend = sourceFriendsGroup.friends[sourceIndexPath.row];
    // 删除哟要移动的数据
    [sourceFriendsGroup.friends removeObjectAtIndex:sourceIndexPath.row];
    
    // 找到要移动的新的组
    QYFriendsGroup *destFriendsGroup = self.groups[destinationIndexPath.section];
    // 找到要移动的新的组的位置
    [destFriendsGroup.friends insertObject:friend atIndex:destinationIndexPath.row];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *filterStr = searchController.searchBar.text;
    
    // 如果filteredStr为nil，或者为空字符串@""
    if (!filterStr || filterStr.length == 0) {
        _isSearching = NO;
        _searchFriends = _groups;
    } else {
        _isSearching = YES;
        
        //拿单元格中name跟搜索框中text进行比较
        //单元格里面的数据对应的是QYFriend ，然后拿friend.name跟text相对比
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", filterStr];
        
        NSMutableArray *filtedArray = [NSMutableArray array];
        for (QYFriendsGroup *fg in _groups) {
            NSArray *array = [fg.friends filteredArrayUsingPredicate:predicate];
            [filtedArray addObjectsFromArray:array];
        }
        _searchFriends = filtedArray;
    }
    [self.tableView reloadData];
}

@end
