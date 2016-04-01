//
//  ZJFiveTableViewController.m
//  百思
//
//  Created by zijia on 3/30/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJFiveTableViewController.h"

#import  <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "ZJTopicCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "fiveTableModel.h"


// 问题； 当网络请求失败， 加的page页码要减回去；
// 记得要保存maxTime因为每次加载更多数据多要求上一次的maxtime。。

// 先下拉刷新, 再上拉刷新第5页数据
        // 下拉刷新成功回来: 只有一页数据, page == 0
        // 上啦刷新成功回来: 最前面那页 + 第5页数据
// 所以要做的是保留请求，， 每次都已最后一次请求为准。 保留params

//每次上啦和下拉刷新之前都要结束 对应的下拉和上啦刷新





@interface ZJFiveTableViewController ()

@property (nonatomic, strong) NSMutableArray *datas;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;




@end

@implementation ZJFiveTableViewController

static NSString * const IDcell = @"topic";


- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setUpRefresh];
    

    
}

- (void)setUpTableView
{

    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = ZJTitilesViewY + ZJTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJTopicCell class]) bundle:nil] forCellReuseIdentifier:IDcell];
}

- (void)setUpRefresh
{
    // 一下啦就刷新。。。。
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动调节透明度在header里
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 一进来就进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    // 加载更多的数据
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData
{
        [self.tableView.mj_header endRefreshing];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"  parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 如果self.params != 最新params 什么也不做
        if (self.params != params) return ;
        
        // 存储maxtime 因为maxTIME是从上一次数据得到的
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        
        // 在loadmore里边 往datas里边加数据 而在loadnew里边是覆盖以前的数据
        NSArray *temp = [fiveTableModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.datas addObjectsFromArray:temp];
        
        
        [self.tableView reloadData];
        
        // header 结束刷新，， 刷新提示消失
        [self.tableView.mj_footer endRefreshing ];
        
        self.page = page;
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) {
                        if (self.params != params) return ;
//            // 回复页码 当数据加载失败恢复页码
//            self.page--;
                                    [self.tableView.mj_footer endRefreshing ];
                                }];
    

    
}




- (void)loadNewData
{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
        self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"  parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
                // 如果self.params != 最新params 什么也不做
        
        if (self.params != params) return;
        // 存储maxtime 因为maxTIME是从上一次数据得到的
        self.maxtime = responseObject[@"info"][@"maxtime"];

                // 在loadmore里边 往datas里边加数据 而在loadnew里边是覆盖以前的数据
        self.datas = [fiveTableModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        // header 结束刷新，， 刷新提示消失
        [self.tableView.mj_header endRefreshing ];
        
        //加载成功了，页码才清为0， 如果加载失败页码不变
            self.page = 0;
    }
                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                            if (self.params != params) return ;
                                            [self.tableView.mj_header endRefreshing ];
                                }];

}





#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.tableView.mj_footer.hidden = (self.datas.count == 0);
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    ZJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    
    cell.datas = self.datas[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    fiveTableModel *data = self.datas[indexPath.row];
    
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * ZJTopicCellMargin, MAXFLOAT);
    
    CGFloat textH = [data.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGFloat cellH = ZJTopicCellTextY + textH +ZJTopicCellBottomBarH + 2*ZJTopicCellMargin;
    
    return cellH;
//    return 250;
}



@end
