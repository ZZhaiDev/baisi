//
//  ZJMeViewController.m
//  百思
//
//  Created by zijia on 2/25/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJMeViewController.h"

@interface ZJMeViewController ()

@end

@implementation ZJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"mine";
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"]  forState:UIControlStateNormal];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
//    
//    /**
//     *  self.messageView.frame.size.height = self.messageView.frame.size.height it is ********* WRONG *********
//     *
//     This is right
//     CGRect temp = self.messageView.frame;
//     temp.size.height = temp.size.height + notesHeight;
//     self.messageView.frame = temp;
//     *      You are able to assign the frame, but not the fields of frame
//     */
//    
//    button1.size = button1.currentBackgroundImage.size;
//    [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
//    /**
//     *  self.navigationItem.rightBarButtonItem = button1;(XXXXXXXXX)
//     *
//     *  self.navigationItem.rightBarButtonItem = (UIBarButtonItem *)button1;(XXXXXXXXXX)
//     */
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" taget:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" taget:self action:@selector(moonClick)];
  
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
}


- (void)settingClick
{
    ZJFunc;
}

- (void)moonClick
{
    ZJFunc;
}


@end
