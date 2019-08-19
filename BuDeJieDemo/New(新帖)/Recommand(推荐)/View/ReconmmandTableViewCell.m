//
//  ReconmmandTableViewCell.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/23.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "ReconmmandTableViewCell.h"

@interface ReconmmandTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@end

@implementation ReconmmandTableViewCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;//这样的话 每个cell后都空出来一部分 就好像有很多section的效果。
    
    //真正给cell赋值的
    [super setFrame:frame];
}

- (void)setRecItem:(ReconmmandItem *)item
{
    _recItem = item;
    
    // 设置内容
    _nameView.text = item.theme_name;
    [self resolveNum:item];
    
    //裁剪图片
    [self.iconView yy_setImageWithURL:[NSURL URLWithString:item.image_list] placeholder:[UIImage imageNamed:@"defaultUserIcon"]options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        // 1.开启上下文
        //比例因素：当前点与像素比例
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);//0是让他自适应。
        // 2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        // 3.设置裁剪区域;
        [path addClip];
        // 4.画图片
        [image drawAtPoint:CGPointZero];
        // 5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        // 6.关闭上下文
        UIGraphicsEndImageContext();
        
        _iconView.image = image;
        
    }];
    
}
-(void)resolveNum:(ReconmmandItem *)item
{
    
    // 判断下有没有>10000
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",item.sub_number] ;
    NSInteger num = item.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _numView.text = numStr;
    
}
// 从xib加载就会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 设置头像圆角,iOS9苹果修复  两种方式：设置圆角切圆角。对图片进行裁剪：
//    _iconView.layer.cornerRadius = 30;
//    _iconView.layer.masksToBounds = YES;
    
//    self.layoutMargins = UIEdgeInsetsZero;//设置cell分割线与屏幕没有间隔，在这里设置一次就好了，如果在cell里设置 会每次调用cell都设置
    
    [self.subBtn.layer setBorderWidth:1.0];
    self.subBtn.layer.borderColor = LXColor(220, 220, 221).CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
