//
//  ZJEssenceViewController.m
//  百思
//
//  Created by zijia on 2/25/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZZJRecommandTableViewController.h"
#import "ZJEssenceViewController.h"

@interface ZJEssenceViewController ()

@end

@implementation ZJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"main page";
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" taget:self action:@selector(button1Click)];
    
    self.view.backgroundColor = ZJBGColor;
    
    
}





- (void)button1Click
{
    ZZJRecommandTableViewController *vc = [[ZZJRecommandTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
