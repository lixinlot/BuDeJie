//
//  TextModel.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/27.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Type) {
    /** 全部 */
    TypeAll = 1,
    TypePicture = 10,
    TypeWord = 29,
    /** 声音 */
    TypeVoice = 31,
    /** 视频 */
    TypeVideo = 41
};


@class TextModelInfo;
@class TextModelList;

@interface TextModel : NSObject

@property (nonatomic, strong) TextModelInfo * info;
@property (nonatomic, strong) NSArray<TextModelList *> * list;


@end

@interface TextModelInfo : NSObject

@property (nonatomic, copy) NSString * vendor;
@property (nonatomic, assign) int  count;
@property (nonatomic, assign) int  page;
@property (nonatomic, copy) NSString * maxid;
@property (nonatomic, copy) NSString * maxtime;


@end

@interface TextModelList : NSObject

///用户的名字
@property (nonatomic, copy) NSString *name;
///用户的头像
@property (nonatomic, copy) NSString *profile_image;
///帖子的文字内容
@property (nonatomic, copy) NSString *text;
///帖子审核通过的时间
@property (nonatomic, copy) NSString *passtime;
///顶数量
@property (nonatomic, assign) NSInteger love;
///踩数量
@property (nonatomic, assign) NSInteger hate;
///转发\分享数量
@property (nonatomic, assign) NSInteger repost;
///评论数量
@property (nonatomic, assign) NSInteger comment;
///声音背景图 大图
@property (nonatomic, copy) NSString * image1;
///声音背景图 小图
@property (nonatomic, copy) NSString * image2;
///声音背景图 略缩图
@property (nonatomic, copy) NSString * image0;
///视频加载时候的静态显示的图片地址
@property (nonatomic, copy) NSString * cdn_img;
///帖子的类型 10为图片 29为段子 31为音频 41为视频
@property (nonatomic, assign) NSInteger type;
///如果为音频，则为音频的播放地址
@property (nonatomic, copy) NSString * voiceuri;
///如果为视频，则为视频的播放地址
@property (nonatomic, copy) NSString * videouri;
///播放次数
@property (nonatomic, assign) NSInteger playfcount;
///如果为音频，则为音频的播放时长
@property (nonatomic, assign) NSInteger voicetime;
///是否是gif动画
@property (nonatomic, assign) BOOL is_gif;
///是否是长图
@property (nonatomic, assign) BOOL is_longImage;
///图片或视频等其他的内容的高度
@property (nonatomic, assign) CGFloat height;
///图片或视频等其他的内容的高度
@property (nonatomic, assign) CGFloat width;

///增加的额外的属性，并非服务器返回的数据，只是为了提高开发效率（根据当前模型计算出来的cell的高度）
@property (nonatomic, assign) CGFloat  cellHeight;

@end
