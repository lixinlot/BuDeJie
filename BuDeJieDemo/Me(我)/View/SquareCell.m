//
//  SquareCell.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/24.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "SquareCell.h"

@interface SquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation SquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [_nameView setAdjustsFontSizeToFitWidth:YES];label适配文字大小
}

-(void)setItem:(SquareItem *)item
{
    _item = item;
    
//    [_iconView yy_setImageWithURL:[NSURL URLWithString:item.icon] options:YYWebImageOptionProgressiveBlur];
    
    _iconView.yy_imageURL = [NSURL URLWithString:item.icon];
    _nameView.text = item.name;
    
}


@end
