//
//  THAssetsDetailViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THAssetsDetailViewController.h"
#import "THAssetsTableViewCell.h"
@interface THAssetsDetailViewController ()
{
    NSMutableArray *titles;
    NSMutableArray *details;
}

@property (nonatomic,weak)IBOutlet UITableView *assetsTableView;


@end

@implementation THAssetsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资产明细";
    [self.assetsTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    titles = @[@"虹包余额",@"实体购物卡",@"电子购物卡",@"VIP卡"];
    details = @[@"¥200.00",@"¥1300.00",@"¥500.00",@"¥500.00"];
    [self.assetsTableView registerNib:[UINib nibWithNibName:@"THAssetsTableViewCell" bundle:nil] forCellReuseIdentifier:@"THAssetsTableViewCell"];
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


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THAssetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THAssetsTableViewCell"];
    [cell refreshCellWithTitle:titles[indexPath.row] detail:details[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ %@",titles[indexPath.row],details[indexPath.row]);
}




@end
