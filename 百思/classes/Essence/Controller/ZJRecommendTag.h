//
//  ZJRecommendTag.h
//  百思
//
//  Created by zijia on 3/27/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJRecommendTag : NSObject

// 图片 image
@property (nonatomic, copy) NSString *image_list;

//名字  name
@property (nonatomic, copy) NSString *theme_name;

// 订阅数  number of substribe
@property (nonatomic, assign) NSInteger sub_number;

@end
