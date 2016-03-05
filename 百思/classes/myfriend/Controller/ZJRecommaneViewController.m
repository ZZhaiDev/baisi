

//  ZJRecommaneViewController.m
//  百思
//
//  Created by zijia on 3/1/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJRecommaneViewController.h"
#import "ZJRecommandTableViewCell.h"
#import "ZJRecommandCategories.h"
#import "ZJRightTableViewCell.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "ZJRight.h"

@interface ZJRecommaneViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (nonatomic, strong) NSArray *leftCategories;
@property (nonatomic, strong) NSArray *rightCategories;

@end

@implementation ZJRecommaneViewController

static NSString *const ZJID = @"category";
static NSString *const ZJRID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.rightTableView.rowHeight = 65;
    
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJRecommandTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZJID ];
      [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJRightTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZJRID ];
    
//     self.leftTableView.backgroundColor = [UIColor redColor];
    
    self.navigationItem.title = @"--welcome--";
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
        
        ZJRecommandCategories *c = self.leftCategories[self.leftTableView.indexPathForSelectedRow.row];
        return c.users.count;
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
    if (c.users.count) {
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
            
            NSArray *data  = [ZJRight objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [c.users addObjectsFromArray:data];
            
            
            [self.rightTableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZJLog(@"%@", error);
       
        }];
        
    }
  
    
    
}



@end
