//
//  tabBarViewController.m
//  百思
//
//  Created by zijia on 2/25/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "tabBarViewController.h"

@interface tabBarViewController ()

@end

@implementation tabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
    
    // add new controller
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.tabBarItem.title = @"jinghua";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    //set the attribuite for tabBarItem for state of UIControlStateNormal
//    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
//    attri[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attri[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [vc1.tabBarItem setTitleTextAttributes:attri forState:UIControlStateNormal];
    
    
//    NSMutableDictionary *attriSelected = [NSMutableDictionary dictionary];
//    attriSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attriSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    [vc1.tabBarItem setTitleTextAttributes:attriSelected forState:UIControlStateSelected];
//    
    vc1.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc1];
    
    
    
    
    // create viewController 2
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.tabBarItem.title = @"新帖";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    vc2.view.backgroundColor = [UIColor blackColor];
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    vc3.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:vc3];
    
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.tabBarItem.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc4.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:vc4];
    
}



@end
