//
//  QYFriends.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYFriends.h"

@implementation QYFriends

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 使用KVC灌入所有的属性
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendsWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
