//
//  ZZJRecommandTableViewController.m
//  百思
//
//  Created by zijia on 3/27/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZZJRecommandTableViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "ZJRecommendTag.h"
#import "ZJRecommandTagCellTableViewCell.h"

@interface ZZJRecommandTableViewController ()

//标签数据
@property (nonatomic, strong) NSArray *tags;

@end

static NSString *const ZJTagID = @"tag";

@implementation ZZJRecommandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    
    [self sendRequest];
    
}
- (void)setUp
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    self.tableView.rowHeight = 80;
    
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJRecommandTagCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZJTagID];
}

- (void)sendRequest
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        
        self.tags = [ZJRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        //        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"loading fail"];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJRecommandTagCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJTagID];
    
    cell.recommandTag = self.tags[indexPath.row];
    
    return cell;
}





@end
