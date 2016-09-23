//
//  THRootViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THRootViewController.h"
#import "THRootCollectionViewCell.h"
#import "THAssetsDetailViewController.h"
#import "THModifyQuickPWDViewController.h"
#import "THForgetPWDViewController.h"
#import "Masonry.h"
#import "PopPasswordView.h"
#import "THMyShoppingCardViewController.h"
#import "THBindingCardViewController.h"
#import "THTradeDetailTableViewController.h"
#import "THBuycardHistoryViewController.h"
#import "THBuyShoppingCardViewController.h"
#import "THNetworkTool.h"
@interface THRootViewController ()<UIActionSheetDelegate,PopPasswordViewDelegate,THRootCollectionViewCellDelegate,UIGestureRecognizerDelegate>
{
    NSArray *titles;
    NSArray *images;
    UIView *pwdInputView;
    THNetworkTool *tool;
}

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *moneyDetailBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *functionCollectionView;

@property (nonatomic)PopPasswordView *passwordView;
@end

@implementation THRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"虹支付";
    tool = [THNetworkTool shareTool];
    tool.target = self;
    self.functionCollectionView.dataSource = self;
    self.functionCollectionView.delegate = self;
    titles = @[@"我的购物卡",@"购买电子卡",@"绑定购物卡",@"交易明细",@"买卡记录",@"帮助中心"];
    images = @[@"icon_rainbow_shopcard",@"icon_rainbow_buycard",@"icon_rainbow_tiecard",@"icon_rainbow_transaction",@"icon_rainbow_buycard_record",@"icon_rainbow_help"];
    
    
    [self.functionCollectionView registerNib:[UINib nibWithNibName:@"THRootCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"THRootCollectionViewCell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_rainbow_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(paysetting)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    
    [self getUserMoreInfo];
    
}

-(void)getUserMoreInfo
{
    //获取用户信息，包括购物卡列表
    [tool GETHttpURL:@"payFunDetaQry" params:nil success:^(NSDictionary *result) {
        
    }];
}

-(void)toBack
{
//    [self.navigationController popViewControllerAnimated:YES];
//    if (_lastVC) {
////        [self.navigationController popToViewController:_lastVC animated:YES];
//        [self.navigationController pushViewController:_lastVC animated:YES];
//    }
//    else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.moneyDetailBtn.layer.cornerRadius = kBtnCorner;
    self.moneyDetailBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    self.moneyDetailBtn.layer.borderWidth = 1;
    NSString *str = @"¥20,000.00";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:35] range:NSMakeRange(1, str.length - 1)];
    self.moneyLabel.attributedText = text;
}

-(IBAction)toAssetsDetailVC:(id)sender
{
    THAssetsDetailViewController *vc = [[THAssetsDetailViewController alloc]initWithNibName:@"THAssetsDetailViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initPWDInputView
{
    if (pwdInputView == nil) {
        pwdInputView = [[UIView alloc]init];
        pwdInputView.backgroundColor = [UIColor lightGrayColor];
        pwdInputView.alpha = 0.5;
        [self.view addSubview:pwdInputView];
        
        UIView *whiteView = [[UIView alloc]init];
        [pwdInputView addSubview:whiteView];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(toClosePWDInputView) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:closeBtn];
        
        
        
        
    }
}

-(void)toClosePWDInputView
{
    
}


-(void)paysetting
{
    if (iOS8before) {
        UIActionSheet *actionsheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"修改交易密码",@"忘记密码", nil];
        actionsheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [actionsheet showInView:self.view];
    }
    else{
        UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *modifyPWD = [UIAlertAction actionWithTitle:@"修改交易密码" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            THModifyQuickPWDViewController *vc = [[THModifyQuickPWDViewController alloc]initWithNibName:@"THModifyQuickPWDViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        UIAlertAction *forgetPWD = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            THForgetPWDViewController *vc = [[THForgetPWDViewController alloc]initWithNibName:@"THForgetPWDViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        UIAlertAction *closePay = [UIAlertAction actionWithTitle:@"关闭虹支付" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            self.passwordView=[[PopPasswordView alloc]initViewwithtype:@"open"];
            self.passwordView.delegate=self;
            self.passwordView.type=@"open";
//            self.passwordView.password.textField.keyboardType = UIKeyboardTypeNumberPad;
//            self.passwordView.password.textField.secureTextEntry = YES;
            [self.view addSubview:self.passwordView];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertCtl addAction:modifyPWD];
        [alertCtl addAction:forgetPWD];
        [alertCtl addAction:closePay];
        [alertCtl addAction:cancleAction];
        [self presentViewController:alertCtl animated:YES completion:nil];
    }
}



- (void)toMyshoppingCard{
    THMyShoppingCardViewController *vc = [[THMyShoppingCardViewController alloc]initWithNibName:@"THMyShoppingCardViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    THRootCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THRootCollectionViewCell" forIndexPath:indexPath];
    [cell refreshCellWithImage:[UIImage imageNamed:images[indexPath.row]] title:titles[indexPath.row] indexPath:indexPath];
    cell.delegate = self;
    return  cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"collcetion.frame w = %.2f,h = %.2f",collectionView.bounds.size.width,collectionView.bounds.size.height);
    return  CGSizeMake((kScreenWidth - 4)/3,(collectionView.bounds.size.height - 3)/2);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Title = %@",titles[indexPath.row]);
}

#pragma mark THRootCollectionViewCellDelegate
-(void)rootCollectionViewCellBeTouched:(NSString *)itemTitle indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Title = %@",itemTitle);
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
        {
            [self toMyshoppingCard];
        }
            break;
        case 1:
        {
            THBuyShoppingCardViewController *vc = [[THBuyShoppingCardViewController alloc]initWithNibName:@"THBuyShoppingCardViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            THBindingCardViewController *vc = [[THBindingCardViewController alloc]initWithNibName:@"THBindingCardViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            THTradeDetailTableViewController *vc = [[THTradeDetailTableViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            THBuycardHistoryViewController *vc = [[THBuycardHistoryViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"修改交易密码"]) {
        THModifyQuickPWDViewController *vc = [[THModifyQuickPWDViewController alloc]initWithNibName:@"THModifyQuickPWDViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([title isEqualToString:@"忘记密码"])
    {
        THForgetPWDViewController *vc = [[THForgetPWDViewController alloc]initWithNibName:@"THForgetPWDViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    else if([title isEqualToString:@"关闭虹支付"]){
//        self.passwordView=[[PopPasswordView alloc]initViewwithtype:@"open"];
//        self.passwordView.delegate=self;
//        self.passwordView.type=@"open";
//        self.passwordView.password.textField.keyboardType = UIKeyboardTypeNumberPad;
//        self.passwordView.password.textField.secureTextEntry = YES;
//        [self.view addSubview:self.passwordView];
//    }
    
    else{
        
    }
}


#pragma mark PopPasswordViewDelegate
-(void)useStoreCode:(NSString *)code
{
    NSLog(@"code = %@",code);
    THForgetPWDViewController *vc = [[THForgetPWDViewController alloc]initWithNibName:@"THForgetPWDViewController" bundle:nil];
    vc.isVerifyClosePay = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)disAction
{
    [self.passwordView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
