//
//  UIView+FramView.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/19.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

//写分类:避免跟其他开发者产生冲突,加前缀
// 如果不想每次获取当前View的Frame都写self.view.frame.size.width或者self.view.bounds.size.width... 之类的 不能直接self.出来 显得很麻烦 这个时候 就可以把Frame抽取出来 给他一个分类 重新他的get和set方法 但是要注意的是 别人也会这样做 当多人开发的时候命名就尤为重要了 为了防止跟别人的一样 可以加一个前缀加以区分 这里就以自己名字的首字母为前缀了。


@interface UIView (FramView)

@property CGFloat lx_width;

@property CGFloat lx_height;

@property CGFloat lx_x;

@property CGFloat lx_y;

@property CGFloat lx_centerX;

@property CGFloat lx_centerY;

@end
