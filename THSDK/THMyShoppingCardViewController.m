//
//  THMyShoppingCardViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/31.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THMyShoppingCardViewController.h"
#import "LiuXSegmentView.h"
#import "LXSegmentScrollView.h"
#import "THShoppingCardTableViewCell.h"
#import "THShoppingCardDetailViewController.h"
#import "THShoppingCardOutTimeDetialViewController.h"
#import "THRootViewController.h"
@interface THMyShoppingCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *consumeDics;
    NSMutableArray *outTimeDics;
}

@property (nonatomic)UITableView *consumeTableView;

@property (nonatomic)UITableView *outTimeTableView;

@property (nonatomic)LXSegmentScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *baseView;

@end

@implementation THMyShoppingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的购物卡";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)toBack
{
    
    [self.navigationController pushViewController:[[THRootViewController alloc]initWithNibName:@"THRootViewController" bundle:nil] animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    consumeDics = [NSMutableArray arrayWithArray:@[@{@"cardType":@"电子卡",@"cardValue":@"500.00",@"cardNumber":@"62230 00000 38923 784"},@{@"cardType":@"实物卡",@"cardValue":@"200.00",@"cardNumber":@"26630 00000 89232 983"}]];
    outTimeDics = [NSMutableArray arrayWithArray:@[@{@"cardType":@"电子卡",@"cardValue":@"500.00",@"cardNumber":@"62230 00000 38923 784"},@{@"cardType":@"实物卡",@"cardValue":@"200.00",@"cardNumber":@"26630 00000 89232 983"}]];
    [_consumeTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_outTimeTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _consumeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _outTimeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)initUI
{
    _consumeTableView = [[UITableView alloc]init];
    _consumeTableView.delegate = self;
    _consumeTableView.dataSource = self;
    
    [_consumeTableView registerNib:[UINib nibWithNibName:@"THShoppingCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"THShoppingCardTableViewCell"];
    
    _outTimeTableView = [[UITableView alloc]init];
    _outTimeTableView.delegate = self;
    _outTimeTableView.dataSource = self;
//    [_consumeTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
//    [_consumeTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_outTimeTableView registerNib:[UINib nibWithNibName:@"THShoppingCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"THShoppingCardTableViewCell"];
    
    _scrollView = [[LXSegmentScrollView alloc]initWithFrame:_baseView.frame titleArray:@[@"待消费",@"已失效"] contentViewArray:@[_consumeTableView,_outTimeTableView]];
    [_baseView addSubview:_scrollView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _consumeTableView) {
        return consumeDics.count;
    }
    return outTimeDics.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 147;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THShoppingCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THShoppingCardTableViewCell"];
    NSDictionary *dic;
    if (tableView == _consumeTableView) {
        
        dic = consumeDics[indexPath.row];
    }
    else{
        dic = outTimeDics[indexPath.row];
    }
    [cell refreshCellWiththumbImageUrl:nil value:dic[@"cardValue"] vailideDate:@"永久有效"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (tableView == _consumeTableView) {
        NSLog(@"Title = %@",consumeDics[indexPath.row][@"cardNumber"]);
        THShoppingCardDetailViewController *vc = [[THShoppingCardDetailViewController alloc]initWithNibName:@"THShoppingCardDetailViewController" bundle:nil];
        vc.paramDic = consumeDics[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        NSLog(@"Title = %@",outTimeDics[indexPath.row][@"cardNumber"]);
        THShoppingCardOutTimeDetialViewController *vc = [[THShoppingCardOutTimeDetialViewController alloc]initWithNibName:@"THShoppingCardOutTimeDetialViewController" bundle:nil];
        vc.paramDic = outTimeDics[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
