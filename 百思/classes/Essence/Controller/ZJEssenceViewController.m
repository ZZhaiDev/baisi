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

//标签栏底部的红色指示器  the red indicator on the buttom of view
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation ZJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    
    [self setTitleView];
    
}

- (void)setUp
{
    self.title = @"main page";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" taget:self action:@selector(button1Click)];
    
    self.view.backgroundColor = ZJBGColor;
}

- (void)setTitleView
{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithWhite:100/100.0 alpha:0.5];
    titleView.width = self.view.width;
    titleView.height = 36;
    titleView.y = 60;
    [self.view addSubview:titleView];

    
    // 内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.height = titleView.height;
        button.width = titleView.width/titles.count;
        button.x = i *button.width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:button];
    }
    
    // 底部的红色指示器 the red indicator on the buttom
    UIView *indicator = [[UIView alloc]init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titleView.height - indicator.height;
    
    [titleView addSubview:indicator];
    self.indicatorView = indicator;
    
}

- (void)titleClick: (UIButton *)button
{
    
    self.indicatorView.width = button.titleLabel.width;
    self.indicatorView.centerX = button.centerX;
}



- (void)button1Click
{
    ZZJRecommandTableViewController *vc = [[ZZJRecommandTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
