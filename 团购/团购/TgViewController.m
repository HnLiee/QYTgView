//
//  TgViewController.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "TgViewController.h"

#import "ResultTableViewController.h"
#import "WebViewController.h"

#import "QYTgModel.h"
#import "QYTgCell.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface TgViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *tgModels;
@property (nonatomic, strong) NSArray *filterArr;
@property (nonatomic) BOOL isSearching;

@end

@implementation TgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scrollViewImage];
    
    [self searchResultViewControll];
    
    // 添加下拉刷新
    UIRefreshControl *freshControl = [[UIRefreshControl alloc] init];
    NSMutableAttributedString *reshStr = [[NSMutableAttributedString alloc] initWithString:@"加载中..."];
    freshControl.tintColor = [UIColor redColor];
    freshControl.attributedTitle = reshStr;
    [self.tableView addSubview:freshControl];
    
    // ⚠️⚠️⚠️⚠️⚠️ 为什么添加AttributedString之后的布局会改变
    // 问题解决:属性字符串必须在添加下拉刷新之前添加（系统问题）
//    NSMutableAttributedString *reshStr = [[NSMutableAttributedString alloc] initWithString:@"加载中..."];
//    freshControl.attributedTitle = reshStr;    
//    freshControl.tintColor = [UIColor redColor];
    
    [freshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)refresh:(UIRefreshControl *)fresh
{
    [fresh performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
}

- (void)searchResultViewControll
{
    ResultTableViewController *resultVC = [[ResultTableViewController alloc] init];
    resultVC.datas = self.tgModels;
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
    
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchResultsUpdater = resultVC;
}

- (IBAction)edit:(UIBarButtonItem *)sender {
    
    if ([sender.title isEqualToString:@"编辑"]) {
        [_tableView setEditing:YES animated:YES];
        sender.title = @"完成";
    } else {
        [_tableView setEditing:NO animated:YES];
        sender.title = @"编辑";
    }
}

- (IBAction)search:(UIBarButtonItem *)sender {
    
    // 点击搜索按钮弹出搜索框
    [self presentViewController:_searchController animated:YES completion:nil];
}

- (void)scrollViewImage
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 375, 142)];
    // 设置contentSize
    scrollView.contentSize = CGSizeMake(kScreenW * 3, 0);
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 142)];
    imgView1.image = [UIImage imageNamed:@"img_01"];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(375, 0, 375, 142)];
    imgView2.image = [UIImage imageNamed:@"img_02"];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(750, 0, 375, 142)];
    imgView3.image = [UIImage imageNamed:@"img_03"];
    
    [scrollView addSubview:imgView1];
    [scrollView addSubview:imgView2];
    [scrollView addSubview:imgView3];
    
    //控制滚动条的显示
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    
    //滚动超过边界会反弹有反弹回来的效果
    scrollView.bounces = NO;
    
    // 翻页
    scrollView.pagingEnabled = YES;
    
    // scrollView显示在表示图的头视图上
    //_tableView.rowHeight = 142;
    _tableView.tableHeaderView = scrollView;
}

- (NSMutableArray *)tgModels
{
    if (_tgModels == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *models = [NSArray arrayWithContentsOfFile:path];
        
        _tgModels = [NSMutableArray array];
        
        for (NSDictionary *dict in models) {
            
            QYTgModel *model = [QYTgModel tgModelWithDictionary:dict];
            [_tgModels addObject:model];
        }
    }
    return _tgModels;
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tgModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYTgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYTgCell" forIndexPath:indexPath];
    
    QYTgModel *model = self.tgModels[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
}

// 编辑 (删除,移动)
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
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 更改数据源(删除)
        [_tgModels removeObjectAtIndex:indexPath.row];
        // 更改界面(删除)
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

// 是否移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 1.从_tgModels中删除当前行的内容
    [_tgModels removeObjectAtIndex:sourceIndexPath.row];
    
    // 2.将_tgModels赋给destionationArray
    NSMutableArray *destionationArray = _tgModels;
    // 3.把移动的数据插入到destionationArray中  (往新位置添加)
    [destionationArray insertObject:_tgModels[sourceIndexPath.row] atIndex:destinationIndexPath.row];
    
}

#pragma mark - tableView delegate

// 选择的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController.tabBarController setHidesBottomBarWhenPushed:YES];
    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.urlString = @"http://www.meituan.com/zttgwm?utm_campaign=baidu&utm_medium=organic&utm_source=baidu&utm_content=zt_search&utm_term=%25E7%25BE%258E%25E5%259B%25A2%25E5%25A4%2596%25E5%258D%2596";
    
    [self.navigationController pushViewController:webVC animated:YES];
}

#if 0

#pragma mark - searchResultsUpdating

// ⚠️⚠️⚠️⚠️⚠️
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *filterStr = searchController.searchBar.text;
    
    // 如果filteredStr为nil，或者为空字符串@""
    if (!filterStr || filterStr.length == 0) {
        _isSearching = NO;
        _filterArr = _tgModels;
    } else {
        _isSearching = YES;        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[CD] %@", filterStr];
        NSMutableArray *title = [NSMutableArray array];
        for (int i = 0; i < self.tgModels.count; i++) {
            QYTgModel *model = self.tgModels[i];
            [title addObject:model.title];
        }
        
        NSMutableArray *resultArr = [NSMutableArray array];
        NSArray *arr = [NSArray array];
        arr = [title filteredArrayUsingPredicate:predicate];
        for (int i = 0; i < arr.count; i++) {
            QYTgModel *model = self.tgModels[i];
            for (NSString *str in arr) {
                if ([model.title containsString:str]) {
                    [resultArr addObject:model];
                }
            }
        }
        _filterArr = resultArr;
    }
    
    [self.tableView reloadData];
}

#endif

@end
