//
//  BuDeJieTabBar.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "BuDeJieTabBar.h"

@interface BuDeJieTabBar()

@property (nonatomic, strong) UIButton * plusButton;
@property (nonatomic, strong) UIControl * previousTabBarButton;

@end

@implementation BuDeJieTabBar

-(UIButton *)plusButton
{
    if (_plusButton == nil) {
        
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [_plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [_plusButton sizeToFit];
        
        [self addSubview:_plusButton];
        
    }
    
    return _plusButton;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //每次调用都会重新生成，所以使用懒加载
    
    //跳转TabBar位置
    NSInteger count = self.items.count;
    CGFloat btnW = self.lx_width / (count + 1);
    CGFloat btnH = self.lx_height;
    CGFloat x = 0;
    int i = 0;
    //私有类：可以打印出来，但是敲出来没有，说明这个类是系统的私有类
    //遍历子控件 调整布局[
    for (UIControl *tabBarButton in self.subviews) {//本来tabBarButton应该是UIView类型的，但是这里要实现点两次刷新，添加点击事件，打印它的父类发现是UIControl 所以改成了UIControl
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            if (self.previousTabBarButton == nil && i == 0) {
//                self.previousTabBarButton = tabBarButton;
//            }
            
            
            if (i == 2) {
                i += 1;
            }
            
            x = i * btnW;
            
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            
            i ++;
            
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    //调整发布按钮的位置
    self.plusButton.center = CGPointMake(self.lx_width * 0.5, self.lx_height * 0.5);
    
    
}
-(void)tabBarButtonClick:(UIControl *)tabBarButton
{
    
    if (self.previousTabBarButton == tabBarButton) {
//        LXFunc;
        //发出通知 被点击了（由于点击每个tabBarButton都要让其对应的控制器知道 所以用 通知 比较好）
        [[NSNotificationCenter defaultCenter] postNotificationName:tabBarButtonDidRepeatClickNotification object:nil userInfo:@{ }] ;
        
        
        
    }
    self.previousTabBarButton = tabBarButton;
    
}





@end
