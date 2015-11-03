//
//  QYTgModel.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYTgModel.h"

@implementation QYTgModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {        
        // 灌入字典
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)tgModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
