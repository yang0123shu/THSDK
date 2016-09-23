//
//  THOrderDetailViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/7.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THOrderDetailViewController.h"
#import "THOrderInfoTableViewCell.h"
@interface THOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,weak)IBOutlet UITableView *tableView;
@end

@implementation THOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
//    [self.tableView setTableHeaderView:[[UIView alloc]initWithFrame:CGRectZero]];
    self.title = @"订单详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    // Do any additional setup after loading the view from its nib.
}
-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3) {
        return 86.0;
    }
    else{
        return 48.0;
    }

}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return [[UIView alloc]initWithFrame:CGRectZero];
//}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [[UIView alloc]initWithFrame:CGRectZero];
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        switch (indexPath.row) {
            case 0:
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"value1"];
                NSArray *arr = _dataSource[indexPath.row];
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"value1"];
                cell.textLabel.textColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
                cell.textLabel.text = arr[0];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
                cell.detailTextLabel.text = arr[1];
                return cell;
    
            }
                break;
            case 1:
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"value1"];
                NSArray *arr = _dataSource[indexPath.row];
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"value1"];
                cell.textLabel.textColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
                cell.textLabel.text = arr[0];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:253/255.0 green:78/255.0 blue:84/255.0 alpha:1];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",arr[1]];
                return cell;
            }
                break;
            case 2:
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"value1"];
                NSArray *arr = _dataSource[indexPath.row];
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"value1"];
                cell.textLabel.textColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
                cell.textLabel.text = arr[0];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
                cell.detailTextLabel.text = arr[1];
                return cell;
            }
                break;
            case 3:
            {
                [tableView registerNib:[UINib nibWithNibName:@"THOrderInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"THOrderInfoTableViewCell"];
                THOrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THOrderInfoTableViewCell"];
                NSArray *arr = _dataSource[indexPath.row];
                NSDictionary *dic = arr[1];
                [cell cellRefreshWithDataDictionary:dic];
                return cell;
            }
                break;
            default:
                return nil;
                break;
        }
    
    
    
//    if (indexPath.row < 3) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"value1Cell"];
//        NSArray *arr = _dataSource[indexPath.row];
//        cell.textLabel.textColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
//        cell.textLabel.text = arr[0];
//        cell.detailTextLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
//        if (indexPath.row == 1) {
//            cell.detailTextLabel.textColor = [UIColor colorWithRed:253/255.0 green:78/255.0 blue:84/255.0 alpha:1];
//        }
//        cell.detailTextLabel.text = arr[1];
//        return cell;
//    }
//    else{
//        [tableView registerNib:[UINib nibWithNibName:@"THOrderInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"THOrderInfoTableViewCell"];
//        THOrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THOrderInfoTableViewCell"];
//        NSArray *arr = _dataSource[indexPath.row];
//        NSDictionary *dic = arr[1];
//        [cell cellRefreshWithDataDictionary:dic];
//        return cell;
//    }
    
}


@end
