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
}

- (void)setCategory:(ZJRecommandCategories *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
    
  
}

@end
