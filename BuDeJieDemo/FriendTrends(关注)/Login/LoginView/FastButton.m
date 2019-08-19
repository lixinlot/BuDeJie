//
//  FastButton.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/24.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "FastButton.h"

@implementation FastButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片位置
    self.imageView.lx_y = 0;
    self.imageView.lx_centerX = self.lx_width * 0.5;
    // 设置标题位置
    self.titleLabel.lx_y = self.lx_height - self.titleLabel.lx_height;
    // 计算文字宽度 , 设置label的宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.lx_centerX = self.lx_width * 0.5;
}



@end
