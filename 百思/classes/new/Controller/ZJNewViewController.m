//
//  ZJNewViewController.m
//  百思
//
//  Created by zijia on 2/25/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJNewViewController.h"

@interface ZJNewViewController ()

@end

@implementation ZJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.navigationItem.title = @"new";
    
//    UIBarButtonItem *button1 = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" taget:self action:@selector(button1Click)];
    
    UIBarButtonItem *button1 = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" taget:self action:@selector(button1Click)];
    self.navigationItem.rightBarButtonItem = button1;
}





- (void)button1Click
{
    ZJFunc;
}

@end
