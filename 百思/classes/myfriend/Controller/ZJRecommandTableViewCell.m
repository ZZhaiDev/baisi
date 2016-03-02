//
//  ZJRecommandTableViewCell.m
//  百思
//
//  Created by zijia on 3/1/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJRecommandTableViewCell.h"
#import "ZJRecommandCategories.h"

@interface ZJRecommandTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *selectedCell;

@end

@implementation ZJRecommandTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.contentView.backgroundColor = ZJColor(244, 244, 244);
//  self.selectedCell.backgroundColor = [UIColor redColor];
//    self.backgroundColor = ZJBGColor;
     self.selectedCell.backgroundColor = ZJColor(219, 21, 26);
}

- (void)setCategory:(ZJRecommandCategories *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
    
  
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // 重新调整内部textLabel的frame
//    self.textLabel.y = 2;
//    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
//}
//



/**
 *  This method moniotr selected cell.
 *
 *
 */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:YES];
    
    self.selectedCell.hidden = !selected;
    
    self.textLabel.textColor = selected? self.selectedCell.backgroundColor : [UIColor blueColor];
    
    // ZJColor(78, 78, 78)
}

@end
