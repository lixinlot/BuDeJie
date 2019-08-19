//
//  UITextField+Placeholder.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/24.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

//交换方法
+(void)load
{
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setLx_PlaceholderMethod = class_getInstanceMethod(self, @selector(setLx_Placeholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, setLx_PlaceholderMethod);
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //给成员属性赋值 runtime给系统的类添加成员属性
    //添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //获取占位文字label控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    //设置占位文字颜色
    placeholderLabel.textColor = placeholderColor;
    
    
}

-(UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}
//设置占位文字
//设置占位文字颜色
-(void)setLx_Placeholder:(NSString *)placeholder
{
    [self setLx_Placeholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
}

@end
