//
//  ZJRecommandCategories.h
//  百思
//
//  Created by zijia on 3/1/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJRecommandCategories : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/**
 *  all the data
 */

@property (nonatomic, strong) NSMutableArray *users;



/**
 *  总数
 */
@property (nonatomic, assign) NSInteger *total;
/**
 *  当前的页码
 */
@property (nonatomic, assign) NSInteger *currentPage;

@end
