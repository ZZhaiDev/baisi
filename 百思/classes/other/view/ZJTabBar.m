//
//  ZJTabBar.m
//  百思
//
//  Created by zijia on 2/26/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJTabBar.h"

@interface ZJTabBar()

@property (nonatomic, weak) UIButton *publishButton;

@end



@implementation ZJTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        self.publishButton = button;
        [self addSubview:button];
    }
    
    return self;
}

- (void)layoutSubviews
{
  self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
  self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat buttonY = 0 ;
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
  
    for (UIView *button in self.subviews) {
     if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
   //   CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
        
    }
    
}

@end
