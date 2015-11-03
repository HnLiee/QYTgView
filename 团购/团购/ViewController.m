//
//  ViewController.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *passwd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 将要进入时要做什么事
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _passwd.text = @"";
    
    //becomeFirstResponder<成为第一响应者> resignFirstResponder<失去第一相应>
    // 让密码的输入框成为第一响应者，这样在注销后光标就能停留在密码的输入框里
    if ([_username.text isEqualToString:@""]) {
        [_username becomeFirstResponder];
        return; // ⚠️⚠️⚠️
    }
    [_passwd becomeFirstResponder];
    // 失去第一相应
    //[_passwd resignFirstResponder];
}

// 收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    //[_username resignFirstResponder];
}

- (IBAction)login:(UIButton *)sender
{
    
}

@end
