//
//  QYStoryboardSegue.m
//  团购
//
//  Created by 学不会 on 15/11/1.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYStoryboardSegue.h"

#import "ViewController.h"

@implementation QYStoryboardSegue

- (void)perform
{
    UIViewController *sourceVC = self.sourceViewController;
    UIViewController *dstVC = self.destinationViewController;
    
    // 判断identifier的身份，如果是@"Login"则走这个逻辑
    // 先判断是否符合条件，不符合就返回，符合了就走下面的逻辑
    // 这样可以减少嵌套层次
    if (![self.identifier isEqualToString:@"Login"]) {
        return;
    }
    
    // 如果登录成功，则切换，否则不且换
    NSString *username = [sourceVC valueForKeyPath:@"username.text"];
    NSString *password = [sourceVC valueForKeyPath:@"passwd.text"];
    
    // 1.如果用户名或密码为空，则弹出警告，并返回
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名或密码为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![username isEqualToString:@"q"] || ![password isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    // 3.收起键盘
    [[sourceVC valueForKey:@"view" ] endEditing:YES];
    
    //试图控制器切换的样式(默认为从下往上垂直进入)
    // 水平翻转
    dstVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // 密码用户名全正确后登陆
    [sourceVC presentViewController:dstVC animated:YES completion:^{
        
    }];
}

@end
