//
//  THBuycardHistoryViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/7.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THBuycardHistoryViewController.h"
#import "THBuycardTableViewCell.h"
#import "THOrderDetailViewController.h"
@interface THBuycardHistoryViewController ()<THBuycardTableViewCellDelegate>
{
    NSMutableArray *dataSource;
}
@end

@implementation THBuycardHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataSource = [NSMutableArray arrayWithArray:@[@{@"date":@"2016-9-3 10:27:43",@"account":@"200.00"},@{@"date":@"2016-9-5 15:28:32",@"account":@"2001.00"},@{@"date":@"2016-9-5 15:28:32",@"account":@"2001.00"},@{@"date":@"2016-9-5 15:28:32",@"account":@"2001.00"},@{@"date":@"2016-9-5 15:28:32",@"account":@"2001.00"}]];
    [self.tableView registerNib:[UINib nibWithNibName:@"THBuycardTableViewCell" bundle:nil] forCellReuseIdentifier:@"THBuycardTableViewCell"];
//    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.title = @"买卡记录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    // Do any additional setup after loading the view from its nib.
}
-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark UITableViewCellDataSource UITableViewCellDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [[UIView alloc]initWithFrame:CGRectZero];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
//
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
//    view.backgroundColor = [UIColor lightGrayColor];
//    return view;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THBuycardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THBuycardTableViewCell"];
    [cell refreshCellWithIndexPath:indexPath data:dataSource[indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    THOrderDetailViewController *vc = [[THOrderDetailViewController alloc]initWithNibName:@"THOrderDetailViewController" bundle:nil];
    vc.dataSource = [NSMutableArray arrayWithArray:@[@[@"买卡时间",@"2016-09-02 16:40:27"],@[@"总金额",@"2000.00"],@[@"发票信息",@"不开发票"],@[@"订单信息",@{@"orderNum":@"2016090289738923",@"orderTrsNum":@"2797389239",@"createdDate":@"2016-09-02 16:40:37"}]]];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark THBuycardTableViewCellDelegate
-(void)didSelectedTableViewCellAtIndexPath:(NSIndexPath *)indexPath contentDic:(NSDictionary *)dic
{
    
}

@end
