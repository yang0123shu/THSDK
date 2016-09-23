//
//  THBuyShoppingCardViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/12.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THBuyShoppingCardViewController.h"
#import "THCardTableViewCell.h"
#import "THCardOptionTableViewCell.h"
@interface THBuyShoppingCardViewController ()<UITableViewDelegate,UITableViewDataSource,THCardTableViewCellDelegate,UIScrollViewDelegate>
{
    NSMutableArray *cardInfo;
    NSMutableArray *optionsInfo;
    CGFloat totalMoney;
}

@property (weak, nonatomic) IBOutlet UITextField *moneyInputTF;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UITableView *shoppingCardTableView;

@property (weak, nonatomic) IBOutlet UITableView *optionTableView;

@property (weak, nonatomic) IBOutlet UIButton *protocolSelectBtn;

@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *balanceBtn;

@end

@implementation THBuyShoppingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    totalMoney = 0.0f;
    self.title = @"购买购物卡";
    NSString *text = @"我已阅读并同意天虹购物卡使用协议";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:text];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:250/255.0 green:47/255.0 blue:47/255.0 alpha:1] range:NSMakeRange(7, text.length - 7)];
    [attri addAttribute:NSUnderlineStyleAttributeName
                  value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                  range:NSMakeRange(7, text.length - 7)];
    [attri addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithRed:250/255.0 green:47/255.0 blue:47/255.0 alpha:1] range:NSMakeRange(7, text.length - 7)];
    self.protocolLabel.attributedText = attri;
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.borderColor = (__bridge CGColorRef _Nullable)(kBtnBgColor);
    self.addBtn.layer.cornerRadius = 10;
    self.addBtn.layer.borderWidth = 0.5;
    self.balanceBtn.layer.cornerRadius = kBtnCorner;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [_shoppingCardTableView registerNib:[UINib nibWithNibName:@"THCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"THCardTableViewCell"];
    [_optionTableView registerNib:[UINib nibWithNibName:@"THCardOptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"THCardOptionTableViewCell"];
    cardInfo = [NSMutableArray arrayWithArray:@[@[@88,@0],@[@100,@0],@[@500,@0],@[@1000,@0]]];
    optionsInfo = [NSMutableArray arrayWithArray:@[@[@"自选卡面",[UIImage imageNamed:@"icon_rainbow_tiecard"]],@[@"发票",@"天虹股份有限公司",@"礼品"]]];
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults valueForKey:@"scrolled"]) {
        [self.shoppingCardTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


- (IBAction)toAddMoney:(id)sender {
}

- (IBAction)toSelectProtocol:(id)sender {
}

- (IBAction)toShowProtocol:(id)sender {
}

- (IBAction)toBalance:(id)sender {
}

#pragma mark UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _shoppingCardTableView) {
        return cardInfo.count;
    }
    return optionsInfo.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _shoppingCardTableView) {
        return 86;
    }else{
        return 40;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _shoppingCardTableView) {
        THCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THCardTableViewCell"];
        [cell refreshCellWithMoney:[NSString stringWithFormat:@"%ld",(long)[cardInfo[indexPath.row][0] integerValue]] bagde:[cardInfo[indexPath.row][1] integerValue] indexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else{
        THCardOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THCardOptionTableViewCell"];
        if (indexPath.row == 0) {
            [cell refreshCellWithImage:optionsInfo[indexPath.row][1] title:optionsInfo[indexPath.row][0] title1:nil title2:nil indexPath:indexPath];
        }
        else{
            [cell refreshCellWithImage:nil title:optionsInfo[indexPath.row][0] title1:optionsInfo[indexPath.row][1] title2:optionsInfo[indexPath.row][2] indexPath:indexPath];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _optionTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == 0) {
            NSLog(@"选择卡面");
            
        }
        else{
            NSLog(@"发票抬头");
            
        }
    }
}

#pragma mark THCardTableViewCellDelegate
-(void)cellDecreasedOrIncreased:(BOOL)increase indexPath:(NSIndexPath *)index money:(NSString *)money
{
    NSLog(@"money = %@",money);
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@YES forKey:@"scrolled"];
}

@end
