

//  ZJRecommaneViewController.m
//  百思
//
//  Created by zijia on 3/1/.
//  Copyright (c) 2016 zijia. All rights reserved.
//
// save the all the right side table data into nsmutablearray Users. if c.users.count means there is data before, so just load the data, do not have to send GET into serve. If c.users.count == nil, send GET to server.

// will not repeat send GET into server


#import "ZJRecommaneViewController.h"
#import "ZJRecommandTableViewCell.h"
#import "ZJRecommandCategories.h"
#import "ZJRightTableViewCell.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "ZJRight.h"
#import <MJRefresh.h>
#define ZJSelectedCategory self.leftCategories[self.leftTableView.indexPathForSelectedRow.row];

@interface ZJRecommaneViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (nonatomic, strong) NSArray *leftCategories;

@end

@implementation ZJRecommaneViewController

static NSString *const ZJID = @"category";
static NSString *const ZJRID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // new alloc tableView
    [self setupTable];
    
    [self refreshTable];
    
    [self loadLeftTable];
    
    
}


- (void)refreshTable
{
    
    self.rightTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)];
    self.rightTableView.footer.hidden = YES;
}



- (void)loadMoreUser
{
    ZJRecommandCategories *c = ZJSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    // ZJSelectedCategory是从array中取出来的 是id类型 所以不能用点语法 不能用 ZJSelectedCategory.id 所以要用［ZJSelectedCategory id］
//    //但是是基本数据类型 要包装成对象放到字典中去打给服务器
//    params[@"category_id"] = @([ZJSelectedCategory id]);
    params[@"category_id"] = @(c.id);
    params[@"page"] = @"2";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *data  = [ZJRight objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [c.users addObjectsFromArray:data];
        
        
        [self.rightTableView reloadData];
        
        if (c.users.count == c.total) {
            [self.rightTableView.footer noticeNoMoreData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZJLog(@"%@", error);
        
       
    }];
    
}

-(void)setupTable
{
    
    self.rightTableView.rowHeight = 65;
    
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJRecommandTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZJID ];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJRightTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZJRID ];
    
    //     self.leftTableView.backgroundColor = [UIColor redColor];
    
    
    //set inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = self.leftTableView.contentInset;
    
    
    self.navigationItem.title = @"--welcome--";
    self.view.backgroundColor = ZJBGColor;
    
}


-(void)loadLeftTable
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPRequestOperationManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
        //        ZJLog(@"%@",responseObject);
        
        self.leftCategories = [ZJRecommandCategories objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        //        self.leftTableView.backgroundColor = [UIColor whiteColor];
        [self.leftTableView reloadData];
                [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"loading fail"];
    }];
}


#pragma mark -- <UITableViewDataSource>

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftCategories.count;
    }else{
        
//        return self.rightCategories.count;
        
        ZJRecommandCategories *c = self.leftCategories[self.leftTableView.indexPathForSelectedRow.row];
        self.rightTableView.footer.hidden = (c.users.count == 0);
          return c.users.count;
        /**
         *  上边三句变为下边三句
         */
//        NSInteger count= [ZJSelectedCategory users].count;
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        ZJRecommandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJID];
        cell.category = self.leftCategories[indexPath.row];
      
        return cell;
       
    }else
    {
    
        ZJRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJRID];
     
        ZJRecommandCategories *c = self.leftCategories[self.leftTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];

      
        return cell;
    }
    
}



#pragma mark -- <UITableViewDelegate>

//UITableViewDelegate: will call this function when select one cell.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // save the all the right side table data into nsmutablearray Users. if c.users.count means there is data before, so just load the data, do not have to send GET into serve. If c.users.count == nil, send GET to server.
    
    // will not repeat send GET into server
    
    ZJRecommandCategories *c = self.leftCategories[indexPath.row];
    
    // 防止重复发送请求
    if (c.users.count) {
        
        // show the data used
        [self.rightTableView reloadData];
    }else{
        
        // will relooad the data before send message to server, which means before show the new data, dismiss the old data.
        
        [self.rightTableView reloadData];

        // 发送请求给服务器, 加载右侧的数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
       
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZJLog(@"%@", responseObject);
            
            NSArray *data  = [ZJRight objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [c.users addObjectsFromArray:data];
            
            // total data //保存总数
            c.total = [responseObject[@"total"] integerValue];
            
            if (c.users.count == c.total) {
                [self.rightTableView.footer noticeNoMoreData];
            }
            
            [self.rightTableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZJLog(@"%@", error);
       
        }];
        
    }
  
    
    
}



@end
