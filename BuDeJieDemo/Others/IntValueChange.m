//
//  IntValueChange.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/5/3.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "IntValueChange.h"

@implementation IntValueChange

+(NSString *)intValueChanged:(NSInteger)number
{
    // 判断下有没有>10000
//    NSString *numLove = [NSString stringWithFormat:@"%ld万",modelList.love];
//    NSString *numHate = [NSString stringWithFormat:@"%ld万",modelList.hate];
//    NSString *numRepost = [NSString stringWithFormat:@"%ld万",modelList.repost];
//    NSString *numComment = [NSString stringWithFormat:@"%ld万",modelList.comment];
//    NSInteger loveCount = modelList.love;
//    NSInteger hateCount = modelList.hate;
//    NSInteger repostCount = modelList.repost;
//    NSInteger commentCount = modelList.comment;
    NSString *numW;
    if (number > 10000) {
        CGFloat numF = number / 10000.0;
        numW = [NSString stringWithFormat:@"%.1f万",numF];
        numW = [numW stringByReplacingOccurrencesOfString:@".0" withString:@""];
        return numW;
    }else{
        return [NSString stringWithFormat:@"%ld",number];
    }
    

}

@end
