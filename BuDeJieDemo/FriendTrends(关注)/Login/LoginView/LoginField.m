//
//  LoginField.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/24.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "LoginField.h"

@implementation LoginField
/*
 1.文本框光标变成白色
 2.文本框开始编辑的时候,占位文字颜色变成白色
 
 // 分析:为什么先设置占位文字颜色,就没有效果 => 占位文字label拿不到
 // 1.保存起来
 // 设置占位文字颜色
 _textField.placeholderColor = [UIColor greenColor];
 
 // 设置占位文字:每次设置占位文字的后,在拿到之前保存占位文字颜色,重新设置
 //    [_textField setXmg_Placeholder:@"123"];
 _textField.placeholder = @"123";
 
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //设置光标为白色
    self.tintColor = [UIColor whiteColor];
    
    //监听文本框编辑 方法：1.代理 2.通知 3.target
    //原则：不要让自己成为代理
    //开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    // 获取占位文字控件
    self.placeholderColor = [UIColor lightGrayColor];
    // 快速设置占位文字颜色 => 文本框占位文字可能是label => 验证占位文字是label => 拿到label => 查看label属性名(1.runtime 2.断点)
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
}
// 文本框开始编辑调用
-(void)textBegin
{
    //设置占位文字颜色变白色
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.placeholderColor = [UIColor whiteColor];
    
}
// 文本框结束编辑调用
-(void)textEnd
{
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.placeholderColor = [UIColor lightGrayColor];
}


@end
