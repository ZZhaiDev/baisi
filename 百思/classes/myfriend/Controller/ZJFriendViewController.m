//
//  ZJFriendViewController.m
//  百思
//
//  Created by zijia on 2/25/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJFriendViewController.h"
#import "ZJRecommaneViewController.h"

@interface ZJFriendViewController ()

@end

@implementation ZJFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //friendsRecommentIcon
    
    self.navigationItem.title = @"My Friends";
 
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
//    
//    button1.size = button1.currentBackgroundImage.size;
//    [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    
    UIBarButtonItem *button1 = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" taget:self action:@selector(button1Click)];
    self.navigationItem.rightBarButtonItem = button1;
    
    
}

- (void)button1Click
{
    ZJRecommaneViewController *vc  = [[ZJRecommaneViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
