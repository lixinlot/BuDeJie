//
//  HMSegmentedControl+SegmentControl.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "HMSegmentedControl+SegmentControl.h"

@implementation HMSegmentedControl (SegmentControl)

+(HMSegmentedControl *)segmentWithTitle:(NSArray *)titles
{
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
    segment.frame = CGRectMake(0, 64, screenWidth, 40);
    segment.backgroundColor = [UIColor clearColor];
    segment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segment.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    segment.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segment.selectionIndicatorHeight = 2;

    segment.selectionIndicatorColor = [UIColor redColor];
    //设置开始时默认选中的下标
    segment.selectedSegmentIndex = 0;
    
    
//    - (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
    
    return segment;
}

@end
