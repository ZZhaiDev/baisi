

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
/**左边类别的表格 */
/**left side tableView */
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
/** 右边类别的表格*/
/**right side tableView */
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
/**左边类别的数据 */
/** data of left side */
@property (nonatomic, strong) NSArray *leftCategories;

/**请求参数*/
/** requrest params */
@property (nonatomic, strong) NSMutableDictionary *params;
/** afn 请求管理者*/
/** AFN manager*/
@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

@implementation ZJRecommaneViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString *const ZJID = @"category";
static NSString *const ZJRID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // new alloc tableView 初始化控件
    [self setupTable];
    
   //add or refresh the new data 添加刷新控件
    [self refreshTable];
    
    // add or load the data of left side table 加载左侧的类别数据
    [self loadLeftTable];
    
    
}




- (void)refreshTable
{
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)];
    self.rightTableView.mj_footer.hidden = YES;
}

- (void)loadMoreUser
{
    ZJRecommandCategories *rc = ZJSelectedCategory;
    
//    发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(++rc.currentPage);
    
    // save the params to self.params .....check if the request is the last request
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //字典转模型
        NSArray *users = [ZJRight mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [rc.users addObjectsFromArray:users];
        
        if (self.params != params) return;
        
        [self.rightTableView reloadData];
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"loading fail"];
        
        
        [self.rightTableView.mj_footer endRefreshing];
        
        
    }];
    
    
    
}


- (void)loadLeftTable
{
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //隐藏指示器 hidden theS VProgressHUD
        [SVProgressHUD dismiss];
        
        
        /**
         *  responseObject is the data returned from sever which is json format.
         responseObject[@"list"] is array[dictionary];
         +(void) objectArrayWithKeyValuesArray is the method that convert the dictionary array to model
         字典转模型
         */
        
        self.leftCategories = [ZJRecommandCategories mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // reload the tableView, so it will reload the dataSource
        // 刷新表格。。
        [self.leftTableView reloadData];
        
        /**
         *  默认第一行为首选行
         default select the first row int the tableView
         */
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"loading fail"];
        
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

/**
 *  load the data of left table
    加载左边表格的数据
 */
-(void)loadNewData
{
 
    
    
    ZJRecommandCategories *rc = ZJSelectedCategory;
    
    
    // 设置当前页码为1   set the current page from server 1
    rc.currentPage = 1;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    
    
    // ZJSelectedCategory是从array中取出来的 是id类型 所以不能用点语法 不能用 ZJSelectedCategory.id 所以要用［ZJSelectedCategory id］
    //    //但是是基本数据类型 要包装成对象放到字典中去打给服务器
    //    params[@"category_id"] = @([ZJSelectedCategory id]);
    params[@"category_id"] = @(rc.id);

     params[@"page"] = @(rc.currentPage);
    
    self.params = params;
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //
        //        NSArray *data  = [ZJRight objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //        [c.users addObjectsFromArray:data];
        //
        NSArray *users   = [ZJRight mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // reomove all the old data from the users
        [rc.users removeAllObjects];
        
        // add the data to the current array
        [rc.users addObjectsFromArray:users ];
        
        
        // save the data of the total- page from server
        rc.total = [responseObject[@"total"] integerValue];
        
        // if it is not the last page(not the last request)
        if (self.params != params) return;
        
        // reload the table of right side
        [self.rightTableView reloadData];
        
        
        //ending the loading
        // used the MJRefresh 第三方框架
        [self.rightTableView.mj_header endRefreshing];
        
        
        // ending the refreshing of footerView
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //        ZJLog(@"%@", error);
        if (self.params != params)return ;
        
        // warning
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // ending refreshing
        [self.rightTableView.mj_header endRefreshing];
        
    }];

    

}

- (void)checkFooterState
{
    ZJRecommandCategories *c = ZJSelectedCategory;
    // everytime reload the data for right side table, always check if the footerView need to be showed
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.rightTableView.mj_footer.hidden = (c.users.count == 0);
    
    
    //stop refreshing of footerView 结束底部控件刷新
    if(c.users.count == c.total){           // if all the data was loaded, noticeNoMoreData
        [self.rightTableView.mj_footer noticeNoMoreData];
    }else{                              // if there is still data in the server, stop refreshing
        [self.rightTableView.mj_footer endRefreshing];
    }
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
        
        ZJRecommandCategories *c = ZJSelectedCategory
        self.rightTableView.mj_footer.hidden = (c.users.count == 0);
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
     
        ZJRecommandCategories *c = ZJSelectedCategory
        cell.user = c.users[indexPath.row];

      
        return cell;
    }
    
}



#pragma mark -- <UITableViewDelegate>

//UITableViewDelegate: will call this function when select one cell.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // end refreshing 结束刷新。。。每次进入这里结束以前的刷新
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    
    
    // save the all the right side table data into nsmutablearray Users. if c.users.count means there is data before, so just load the data, do not have to send GET into serve. If c.users.count == nil, send GET to server.
    
    // will not repeat send GET into server
    
    ZJRecommandCategories *c = self.leftCategories[indexPath.row];
    
    // 防止重复发送请求
    if (c.users.count) {
        
        // show the data used
        [self.rightTableView reloadData];
    }else{
        
        // will relooad the data before send message to server, which means before show the new data, dismiss the old data.
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        
        [self.rightTableView reloadData];

//        // 发送请求给服务器, 加载右侧的数据
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"a"] = @"list";
//        params[@"c"] = @"subscribe";
//        params[@"category_id"] = @(c.id);
//       
//        [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            ZJLog(@"%@", responseObject);
//            
//            NSArray *data  = [ZJRight objectArrayWithKeyValuesArray:responseObject[@"list"]];
//            [c.users addObjectsFromArray:data];
//            
//            // total data //保存总数
//            c.total = [responseObject[@"total"] integerValue];
//            
//            if (c.users.count == c.total) {
//                [self.rightTableView.footer noticeNoMoreData];
//            }
//            
//            [self.rightTableView reloadData];
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            ZJLog(@"%@", error);
//       
//        }];
        
        
        // 在这个方法中， 不再使用以上给服务器直接发送请求，而是调用[self.rightTableView.mj_header beginRefreshing];进入下啦状态， 一旦进入下拉刷新状态就会调用setuprefresh 在调用－loadnewusers()
        // in the method of didSelectRowAtIndexPath, I do not send the get request directly anymore. I choose to use the method of [self.rightTableView.mj_header beginRefreshing] to get in the header refresh status, after that controller will call setUpRefresh and then Call the method of loadNewUsers() autoly.
        
        [self.rightTableView.mj_header beginRefreshing];
        
    }
  
    
    
}


#pragma mark -- 销毁控制器  dealloc controller
// ex.  one send a request and then go to another controller. after the data return back from server, the app will dump.
// so when one go to another controller, we need to cancel all the request in the controller.

- (void)dealloc
{
    
    // cancel all the operations
    [self.manager.operationQueue cancelAllOperations];
    
}


@end
