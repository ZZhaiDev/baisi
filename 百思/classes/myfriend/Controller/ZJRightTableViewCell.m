//
//  ZJRightTableViewCell.m
//  百思
//
//  Created by zijia on 3/1/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJRightTableViewCell.h"
#import "ZJRight.h"
#import <UIImageView+WebCache.h>

@interface ZJRightTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation ZJRightTableViewCell

- (void)setUser:(ZJRight *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd 人关注",  user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}


@end
