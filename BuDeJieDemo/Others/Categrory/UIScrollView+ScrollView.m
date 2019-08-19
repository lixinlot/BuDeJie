//
//  UIScrollView+ScrollView.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "UIScrollView+ScrollView.h"

@implementation UIScrollView (ScrollView)

+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame contenSize:(CGSize)contentSize tag:(NSInteger)tag
{
     UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = contentSize;
    

    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = LXColor(220, 220, 221);
    
    scrollView.tag = tag;
    
    return scrollView;
    
}

@end
