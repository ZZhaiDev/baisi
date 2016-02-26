//
//  tabBarViewController.m
//  百思
//
//  Created by zijia on 2/25/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "tabBarViewController.h"
#import "ZJEssenceViewController.h"
#import "ZJFriendViewController.h"
#import "ZJMeViewController.h"
#import "ZJNewViewController.h"

@interface tabBarViewController ()

@end

@implementation tabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     *  set all items' font and color attributes in UITabBarItem by using ***appeaercnce***.
        UI_APPEARANCE_SELECTOR
     */
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
    
    
    
    
//    // add new controller
//    UIViewController *vc1 = [[UIViewController alloc]init];
//    vc1.tabBarItem.title = @"jinghua";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    
//  
//    vc1.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc1];
//    
//    
//    
//    
//    // create viewController 2
//    UIViewController *vc2 = [[UIViewController alloc]init];
//    vc2.tabBarItem.title = @"新帖";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//    vc2.view.backgroundColor = [UIColor blackColor];
//    [self addChildViewController:vc2];
//    
//    UIViewController *vc3 = [[UIViewController alloc]init];
//    vc3.tabBarItem.title = @"关注";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    vc3.view.backgroundColor = [UIColor grayColor];
//    [self addChildViewController:vc3];
//    
//    
//    UIViewController *vc4 = [[UIViewController alloc]init];
//    vc4.tabBarItem.title = @"我";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
//    vc4.view.backgroundColor = [UIColor blueColor];
//    [self addChildViewController:vc4];
    
    [self setUpNewController:[[ZJEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" seletedImage:@"tabBar_essence_click_icon"];
     [self setUpNewController:[[ZJNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" seletedImage:@"tabBar_new_click_icon"];
     [self setUpNewController:[[ZJFriendViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" seletedImage:@"tabBar_friendTrends_click_icon"];
     [self setUpNewController:[[ZJMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" seletedImage:@"tabBar_me_click_icon"];
    
}

- (void)setUpNewController:(UIViewController *)vc title:(NSString *)title image:(NSString  *)images seletedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:images];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:vc];
}



@end
