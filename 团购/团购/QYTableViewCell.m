//
//  QYTableViewCell.m
//  团购
//
//  Created by 学不会 on 15/11/1.
//  Copyright (c) 2015年 hnqingyun. All rights reserved.
//

#import "QYTableViewCell.h"

#import "QYTgModel.h"

@interface QYTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *buycount;

@end

@implementation QYTableViewCell

- (void)setModel:(QYTgModel *)model
{
    _model = model;
    
    _imgView.image = [UIImage imageNamed:model.icon];
    _title.text = model.title;
    _price.text = model.price;
    _buycount.text = model.buycount;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
