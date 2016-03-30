//
//  ZJFiveTableViewController.m
//  百思
//
//  Created by zijia on 3/30/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJFiveTableViewController.h"

@interface ZJFiveTableViewController ()

@end

@implementation ZJFiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"----%ld行row",(long)indexPath.row];

    return cell;
}



@end
