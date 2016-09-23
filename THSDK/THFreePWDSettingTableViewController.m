//
//  THFreePWDSettingTableViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/5.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THFreePWDSettingTableViewController.h"
#import "THFreePwdSettingTableViewCell.h"
@interface THFreePWDSettingTableViewController ()
{
    NSInteger selectedRow;
    NSInteger newRow;
    
}
@end

@implementation THFreePWDSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免密金额";
    [self.tableView registerNib:[UINib nibWithNibName:@"THFreePwdSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"THFreePwdSettingTableViewCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    selectedRow = 0;
    THFreePwdSettingTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell refreshCellWithMoneyCount:[self.dataSource[0] integerValue] isSelected:YES];
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
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     THFreePwdSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THFreePwdSettingTableViewCell"];
    
    [cell refreshCellWithMoneyCount:[self.dataSource[indexPath.row] integerValue] isSelected:NO];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    newRow = indexPath.row;
    if (newRow != selectedRow) {
        THFreePwdSettingTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell refreshCellWithMoneyCount:[self.dataSource[indexPath.row] integerValue] isSelected:YES];
        if (_delegate && [_delegate respondsToSelector:@selector(popBackSelectedCount:)]) {
            [_delegate popBackSelectedCount:cell.countentLable.text];
        }
        THFreePwdSettingTableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0]];
        [cell1 refreshCellWithMoneyCount:[self.dataSource[selectedRow] integerValue] isSelected:NO];
    }
    selectedRow = indexPath.row;
    
    //发起网络请求
    
    [self toBack];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

@end
