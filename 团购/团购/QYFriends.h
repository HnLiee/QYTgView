//
//  QYFriends.h
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYFriends : NSObject

// 声明属性
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic) BOOL vip;

// 声明初始化方法
- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)friendsWithDictionary:(NSDictionary *)dict;

@end
