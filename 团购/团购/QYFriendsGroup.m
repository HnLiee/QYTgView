//
//  QYFriendsGroup.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYFriendsGroup.h"

#import "QYFriends.h"

@implementation QYFriendsGroup

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in _friends) {
            QYFriends *friend = [QYFriends friendsWithDictionary:dict];
            [array addObject:friend];
        }
        _friends = array;
        _isOpen = NO;
    }
    return self;
}

+ (instancetype)groupWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
