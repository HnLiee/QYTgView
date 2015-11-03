//
//  QYFriendsGroup.h
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYFriendsGroup : NSObject

@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) int online;
@property (nonatomic) BOOL isOpen;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)groupWithDictionary:(NSDictionary *)dict;

@end
