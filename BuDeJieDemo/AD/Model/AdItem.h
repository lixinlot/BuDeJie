//
//  AdItem.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/22.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdItem : NSObject

// w_picurl,ori_curl:跳转到广告界面,w,h


/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@end
