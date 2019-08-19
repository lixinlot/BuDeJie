//
//  FastLoginView.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/24.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "FastLoginView.h"

@implementation FastLoginView

+(instancetype)fastLoginView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    
}


@end
