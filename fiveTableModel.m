//
//  fiveTableModel.m
//  百思
//
//  Created by Zijia Zhai on 3/30/16.
//  Copyright © 2016 zijia. All rights reserved.
//

#import "fiveTableModel.h"

@implementation fiveTableModel



- ( CGFloat) height
{
    if (!_height) {
    
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * ZJTopicCellMargin, MAXFLOAT);
    
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    _height = ZJTopicCellTextY + textH +ZJTopicCellBottomBarH + 2*ZJTopicCellMargin;
    
    }
    
    return _height;
}

@end
