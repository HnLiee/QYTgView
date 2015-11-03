//
//  QYTgCell.m
//  团购
//
//  Created by 学不会 on 15/10/28.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYTgCell.h"

#import "QYTgModel.h"

@implementation QYTgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(QYTgModel *)model
{
    _model = model;
    
    _icon.image = [UIImage imageNamed:model.icon];
    _title.text = model.title;
    _price.text = model.price;
    _buycount.text = model.buycount;
}

@end
