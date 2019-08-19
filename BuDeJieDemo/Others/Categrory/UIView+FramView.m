//
//  UIView+FramView.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/19.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "UIView+FramView.h"

@implementation UIView (FramView)

-(void)setLx_width:(CGFloat)lx_width
{
    CGRect rect = self.frame;
    rect.size.width = lx_width;
    self.frame = rect;
}
-(CGFloat)lx_width
{
    return self.frame.size.width;
}

-(void)setLx_height:(CGFloat)lx_height
{
    CGRect rect = self.frame;
    rect.size.height = lx_height;
    self.frame = rect;
}
-(CGFloat)lx_height
{
    return self.frame.size.height;
}

-(void)setLx_x:(CGFloat)lx_x
{
    CGRect rect = self.frame;
    rect.origin.x = lx_x;
    self.frame = rect;
}
-(CGFloat)lx_x
{
    return self.frame.origin.x;
}

-(void)setLx_y:(CGFloat)lx_y
{
    CGRect rect = self.frame;
    rect.origin.y = lx_y;
    self.frame = rect;
}
-(CGFloat)lx_y
{
    return self.frame.origin.y;
}

-(void)setLx_centerX:(CGFloat)lx_centerX
{
    CGPoint center = self.center;
    center.x = lx_centerX;
    self.center = center;
}
-(CGFloat)lx_centerX
{
    return self.center.x;
}

-(void)setLx_centerY:(CGFloat)lx_centerY
{
    CGPoint center = self.center;
    center.y = lx_centerY;
    self.center = center;
}
-(CGFloat)lx_centerY
{
    return self.center.y;
    
}

@end
