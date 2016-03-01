//
//  ZJRecommaneViewController.m
//  百思
//
//  Created by zijia on 3/1/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJRecommaneViewController.h"
#import "ZJRecommandTableViewCell.h"
#import "ZJRecommandCategories.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface ZJRecommaneViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (nonatomic, strong) NSArray *leftCategories;

@end

@implementation ZJRecommaneViewController

static NSString *const ZJID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
       self.view.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.title = @"--welcome--";
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPRequestOperationManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [SVProgressHUD dismiss];
        
        ZJLog(@"%@",responseObject);
        
        self.leftCategories = [ZJRecommandCategories objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
  
        
        
            
        
        
        
        self.leftTableView.backgroundColor = [UIColor whiteColor];
        [self.leftTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [SVProgressHUD showErrorWithStatus:@"loading fail"];
    }];
    
    
}


#pragma mark -- <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJRecommandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJID];
    
    cell.category = self.leftCategories[indexPath.row];
    
    return cell;
}




@end
