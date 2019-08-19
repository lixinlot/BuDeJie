//
//  UIScrollView+ScrollView.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ScrollView)

+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame contenSize:(CGSize)contentSize tag:(NSInteger)tag;

@end
