//
//  THTradeDetailTableViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THTradeDetailTableViewController.h"
#import "THTradeDetailTableViewCell.h"
#import "THTradeDetailViewController.h"
@interface THTradeDetailTableViewController ()
{
    NSMutableArray *datasource;
}
@end

@implementation THTradeDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易明细";
    self.view.backgroundColor = kViewBgColor;
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.tableView registerNib:[UINib nibWithNibName:@"THTradeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"THTradeDetailTableViewCell"];
    datasource = [NSMutableArray array];
    for (int i = 0; i < 4; i ++) {
        NSDictionary *dic = @{@"title":@"转赠",@"date":@"2016-07-30 17:02:39",@"result":@"- ¥500.00"};
        [datasource addObject:dic];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    // Do any additional setup after loading the view from its nib.
}
-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datasource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THTradeDetailTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"THTradeDetailTableViewCell"];
    
    // Configure the cell...
    NSDictionary * dic = datasource[indexPath.row];
    [cell refreshCellWithTitle:dic[@"title"] date:dic[@"date"] tradeResult:dic[@"result"]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    THTradeDetailViewController *vc = [[THTradeDetailViewController alloc]initWithNibName:@"THTradeDetailViewController" bundle:nil];
    vc.paramDic = datasource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
