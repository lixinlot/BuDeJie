//
//  TextModel.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/27.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [TextModelList class]};
}



@end

@implementation TextModelInfo

@end

@implementation TextModelList

//-(CGFloat)cellHeight
//{
//    CGSize size = [model.text boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
//    
//    return _cellHeight;
//}

@end
