//
//  ZJRecommandTagCellTableViewCell.m
//  百思
//
//  Created by zijia on 3/27/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJRecommandTagCellTableViewCell.h"
#import "ZJRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface ZJRecommandTagCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation ZJRecommandTagCellTableViewCell


- (void)setRecommandTag:(ZJRecommendTag *)recommandTag
{
    
    _recommandTag = recommandTag;
    
    // set the title
    self.themeNameLable.text = recommandTag.theme_name;
    
    
    
    // set the number of substribe
    NSString *tempNumber = nil;
    if (recommandTag.sub_number < 1000) {
        tempNumber = [NSString stringWithFormat:@"%ld substribed",(long)recommandTag.sub_number];
    }else{
        tempNumber = [NSString stringWithFormat:@"%.1fk substribed",(long)recommandTag.sub_number/1000.0];
    }
    self.subNumberLabel.text = tempNumber;
    
    // set the image ...  [UIImage imageNamed:@"defaultUserIcon"] if there is no image, user the default image @"defaultUserIcon"
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommandTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    
}




@end
