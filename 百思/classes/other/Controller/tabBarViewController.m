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
#import "ZJTabBar.h"

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
    
    
    [self setUpNewController:[[ZJEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" seletedImage:@"tabBar_essence_click_icon"];
     [self setUpNewController:[[ZJNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" seletedImage:@"tabBar_new_click_icon"];
     [self setUpNewController:[[ZJFriendViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" seletedImage:@"tabBar_friendTrends_click_icon"];
     [self setUpNewController:[[ZJMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" seletedImage:@"tabBar_me_click_icon"];
    
    /**
     *  self.tabBar is read-only, so we can not just use: self.tabBar = [[ZJTabBar alloc] init];
     *  but we can use KVC to assign value to _tabBar
     *  @return
     */
    
    
    [self setValue:[[ZJTabBar alloc]init] forKey:@"tabBar"];

}

- (void)setUpNewController:(UIViewController *)vc title:(NSString *)title image:(NSString  *)images seletedImage:(NSString *)selectedImage
{
    
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:images];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    

    [self addChildViewController:nvc];
}



@end
