//
//  UIImage+NotRenderImage.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "UIImage+NotRenderImage.h"

@implementation UIImage (NotRenderImage)


+(UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



@end
