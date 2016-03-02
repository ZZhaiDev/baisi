//
//  ZJRight.h
//  百思
//
//  Created by zijia on 3/1/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJRight : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
