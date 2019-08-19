//
//  PictureTableViewCell.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "PictureTableViewCell.h"

@interface PictureTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
// 只需要把 `UIImageView` 替换为 `YYAnimatedImageView` 即可。
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet UIView *containImageView;

/** 比例约束 */
@property (weak, nonatomic) NSLayoutConstraint *ratioLC;
/** 赋值比例 */
@property (nonatomic, assign) CGFloat ratio;

@end

@implementation PictureTableViewCell

#pragma mark - 设置每行cell的间隔
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}
#pragma mark- 重写Model的set方法
-(void)setTextModelList:(TextModelList *)textModelList
{
    _textModelList = textModelList;
    
    self.nameLabel.text = textModelList.name;
    self.timeLabel.text = textModelList.passtime;
    
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.profile_image] options:YYWebImageOptionProgressiveBlur];
    
    self.contentLabel.text = textModelList.text;
    
//    self.contentImageView.yy_imageURL = [NSURL URLWithString:textModelList.image1];
    
    if (textModelList.is_gif){
        self.contentImageView.yy_imageURL = [NSURL URLWithString:textModelList.image1];
        
    }else{
        [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.image1] options:YYWebImageOptionProgressiveBlur];
        //处理超长图片的大小(超长图片设置模式为top可能会导致显示不完全，所以要解决 用上下文)
        if (textModelList.is_longImage) {
            CGFloat imageW = self.containImageView.frame.size.width;
            CGFloat imageH = imageW *textModelList.height / textModelList.width;
            //开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            //绘制图片到上下文中
            [self.contentImageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.contentImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
        }
    }
    if (textModelList.is_longImage) {
        self.seeBigPictureButton.hidden = NO;
        self.contentImageView.contentMode = UIViewContentModeTop;
        self.contentImageView.clipsToBounds = YES;
    }else{
        self.seeBigPictureButton.hidden = YES;
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        self.contentImageView.clipsToBounds = NO;

    }
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.love] forState:UIControlStateNormal];
    [self.hateButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.hate] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.repost] forState:UIControlStateNormal];
    [self.messageButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.comment] forState:UIControlStateNormal];
    
}
#pragma mark - 点击按钮看大图
- (IBAction)seeBigPicture:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"presentBigVCClickNotification" object:nil userInfo:@{@"key" : self.textModelList}];
}

- (void)setRatio:(CGFloat)ratio {
    // "view1.attr1 = view2.attr2 * multiplier + constant"
    _ratioLC = [NSLayoutConstraint constraintWithItem:self.contentImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentImageView attribute:NSLayoutAttributeWidth multiplier:ratio constant:0];
    [self.contentImageView addConstraint:_ratioLC];
}  

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 45 / 2;
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.contentImageView.userInteractionEnabled = YES;
    
    [self.contentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture:) ] ];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
