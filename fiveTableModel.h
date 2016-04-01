//
//  fiveTableModel.h
//  百思
//
//  Created by Zijia Zhai on 3/30/16.
//  Copyright © 2016 zijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fiveTableModel : NSObject


/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, assign) CGFloat height;


@end
