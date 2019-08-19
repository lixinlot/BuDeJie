//
//  TextTableViewCell.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"


@interface TextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;


@property (nonatomic, strong) TextModelList * textModelList;

@end
