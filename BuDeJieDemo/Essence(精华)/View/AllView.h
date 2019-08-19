//
//  AllView.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HomeTableView_AllView         = 1,//全部的cell
    HomeTableView_VedioView       = 2,//视频的cell
    HomeTableView_SoundView       = 3,//声音的cell
    HomeTableView_PictureView     = 4,//图片的cell
    HomeTableView_TextView        = 5,//段子的cell
    
}HomeTableView;


@interface AllView : UIView

+ (AllView *)initWith:(HomeTableView)type x:(int)x;
- (void)getDataFormServer:(BOOL)isMore;

@end
