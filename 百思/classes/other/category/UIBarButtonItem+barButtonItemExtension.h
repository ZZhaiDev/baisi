//
//  UIBarButtonItem+barButtonItemExtension.h
//  百思
//
//  Created by zijia on 2/27/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (barButtonItemExtension)

+ (instancetype)itemWithImage:(NSString *)normalImage highImage:(NSString *)highImage taget:(id)target action:(SEL)action;

@end
