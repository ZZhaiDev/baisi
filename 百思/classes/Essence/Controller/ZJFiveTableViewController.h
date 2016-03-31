//
//  ZJFiveTableViewController.h
//  百思
//
//  Created by zijia on 3/30/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum {
    

        ZJTopicTypeAll = 1,
        ZJTopicTypePicture = 10,
        ZJTopicTypeWord = 29,
        ZJTopicTypeVoice = 31,
        ZJTopicTypeVideo = 41


    
}ZJTopicType;

@interface ZJFiveTableViewController : UITableViewController


/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) ZJTopicType type;


@end
