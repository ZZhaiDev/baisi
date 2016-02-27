//
//  UIBarButtonItem+barButtonItemExtension.m
//  百思
//
//  Created by zijia on 2/27/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "UIBarButtonItem+barButtonItemExtension.h"

@implementation UIBarButtonItem (barButtonItemExtension)

+ (instancetype)itemWithImage:(NSString *)normalImage highImage:(NSString *)highImage taget:(id)target action:(SEL)action
{
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    button1.size = button1.currentBackgroundImage.size;
    
    
    [button1 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button1];
}



@end
