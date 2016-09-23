//
//  THPaySettingViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THPaySettingViewController.h"
#import "THPaySettingCheckTableViewCell.h"
#import "THPaySettingNomalTableViewCell.h"
#import "THFreePWDSettingTableViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
//#import "SVProgressHUD.h"
#import "THStopPayCodeViewController.h"
#import "MBProgressHUD.h"
#import "PopPasswordView.h"
#import "THNetworkTool.h"
@interface THPaySettingViewController ()<UITableViewDelegate,UITableViewDataSource,THPaySettinCheckCellDelegate,THFreePWDSettingVCDelegate,PopPasswordViewDelegate>
{
    NSMutableArray *dataSource;
    NSIndexPath *selectedIndexPath;
    THNetworkTool *tool;
    NSString *_token;
    NSString *touchOpenOrClose;
}

@property (nonatomic)PopPasswordView *passwordView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation THPaySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款设置";
    dataSource = [NSMutableArray arrayWithArray:@[@[@"停用付款码"],@[@[@"单笔免密支付",@YES],@"单笔免密金额"],@[@[@"单笔支付限额",@YES],@"单笔密码支付限额",],@[@[@"单日累计支付限额",@YES],@"单日累计密码支付限额"]]];
    [self.tableView registerNib:[UINib nibWithNibName:@"THPaySettingNomalTableViewCell" bundle:nil] forCellReuseIdentifier:@"THPaySettingNomalTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"THPaySettingCheckTableViewCell" bundle:nil] forCellReuseIdentifier:@"THPaySettingCheckTableViewCell"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popBackPWD:) name:@"POPPASSWORDVIEWREMOVE" object:nil];
    tool = [THNetworkTool shareTool];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)popBackPWD:(NSNotification*)notification
{
    
    NSLog(@"notification = %@",notification);
    [self disAction];
    
    if ([touchOpenOrClose isEqualToString:@"停用付款码"]) {
        [tool getTokenBlock:^(NSString *token) {
            _token = token;
            NSDictionary *postDic = @{@"pin_data":notification.object,@"resToken":_token};
            [tool POSHttpURL:@"closePayConfirm" params:postDic success:^(NSDictionary *result) {
                dataSource = @[@[@"开启付款码"]];
                [self.tableView beginUpdates];
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)] withRowAnimation:UITableViewRowAnimationTop];
                
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
            }];
        }];
        
    }else if([touchOpenOrClose isEqualToString:@"开启付款码"]){
        [tool getTokenBlock:^(NSString *token) {
            _token = token;
            NSDictionary *postDic = @{@"pin_data":notification.object,@"resToken":_token};
            [tool POSHttpURL:@"openPayConfirm" params:postDic success:^(NSDictionary *result) {
                dataSource = [NSMutableArray arrayWithArray:@[@[@"停用付款码"],@[@[@"单笔免密支付",@YES],@"单笔免密金额"],@[@[@"单笔支付限额",@YES],@"单笔密码支付限额",],@[@[@"单日累计支付限额",@YES],@"单日累计密码支付限额"]]];
                [self.tableView beginUpdates];
                [self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)] withRowAnimation:UITableViewRowAnimationTop];
                
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [self.tableView endUpdates];
            }];
        }];
    }
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = dataSource[section];
    return arr.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    if (section == 2) {
        label.frame = CGRectMake(0, 0, kScreenWidth, 40);
        label.text = @"单笔交易使用手机付款，金额≤200元/笔，无需输入支付密码。";
    }
    else if(section == 3){
        label.frame = CGRectMake(0, 0, kScreenWidth, 40);
        label.text = @"单笔交易使用手机付款，金额≥2000元/笔限额，将不能支付。";
    }
    label.numberOfLines = 0;
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 10;
    }
    else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 40;
    }
    else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        label.text = @"单日交易使用手机付款，累计金额≥20000元/笔限额，将不能付款";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor lightGrayColor];
        label.numberOfLines = 0;
        return label;
    }
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case 0:
        {
            THPaySettingNomalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THPaySettingNomalTableViewCell"];
            if (row == 0) {
                
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row] subscriptTitle:nil];
                return cell;
            }
            else{
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row] subscriptTitle:nil];
                return cell;
            }
            
        }
            break;
        case 1:
        {
            if (row == 0) {
                THPaySettingCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THPaySettingCheckTableViewCell"];
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row][0] isOn:[dataSource[indexPath.section][indexPath.row][1] boolValue] indexPath:indexPath];
                cell.delegate = self;
                return cell;
            }
            else{
                THPaySettingNomalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THPaySettingNomalTableViewCell"];
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row] subscriptTitle:@"200/笔"];
                return  cell;
            }
        }
            break;
        case 2:
        {
            if (row == 0) {
                THPaySettingCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THPaySettingCheckTableViewCell"];
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row][0] isOn:[dataSource[indexPath.section][indexPath.row][1] boolValue] indexPath:indexPath];
                cell.delegate = self;
                return cell;
            }
            else{
                THPaySettingNomalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THPaySettingNomalTableViewCell"];
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row] subscriptTitle:@"2000/笔"];
                return  cell;
            }
        }
            break;
        case 3:
        {
            if (row == 0) {
                THPaySettingCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THPaySettingCheckTableViewCell"];
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row][0] isOn:[dataSource[indexPath.section][indexPath.row][1] boolValue] indexPath:indexPath];
                cell.delegate = self;
                return cell;
            }
            else{
                THPaySettingNomalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THPaySettingNomalTableViewCell"];
                [cell refreshCellWithTitle:dataSource[indexPath.section][indexPath.row] subscriptTitle:@"20000/笔"];
                return  cell;
            }
        }
            break;
        default:
            return nil;
            break;
            
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = indexPath;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    THFreePWDSettingTableViewController *vc = [[THFreePWDSettingTableViewController alloc]init];
    vc.dataSource = [NSMutableArray arrayWithArray:@[@200,@400,@600,@800,@1000]];
    vc.delegate = self;
    switch (section) {
        case 0:
        {
            if (row == 0) {
                
                THPaySettingNomalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                touchOpenOrClose = cell.normalTitleLabel.text;
                
//                THStopPayCodeViewController *payvc = [[THStopPayCodeViewController alloc]initWithNibName:@"THStopPayCodeViewController" bundle:nil];
//                payvc.isStoppingPaycode = YES;
//                [self.navigationController pushViewController:payvc animated:YES];
                self.passwordView=[[PopPasswordView alloc]initViewwithtype:@"open"];
                self.passwordView.delegate=self;
                self.passwordView.type=@"open";
                //            self.passwordView.password.textField.keyboardType = UIKeyboardTypeNumberPad;
                //            self.passwordView.password.textField.secureTextEntry = YES;
                [self.view addSubview:self.passwordView];
                
            }
            else{
//                [self.navigationController pushViewController:vc animated:YES];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                LAContext *context = [[LAContext alloc]init];
                NSError *error;
                BOOL touchidAble = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
                if (touchidAble) {
                    
                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹验证" reply:^(BOOL success, NSError * _Nullable error) {
                        
//                        NSLog(@"%d,%@",success,error);
//                        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
//                        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//                        [SVProgressHUD showSuccessWithStatus:@"验证成功"];
//                    
//                        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
//                        dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                            [SVProgressHUD dismiss];
//                            
//                        });
                        
                    }];
                }
                else{
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.animationType = MBProgressHUDAnimationZoomOut;
                    hud.bezelView.color = [UIColor lightGrayColor];
                    // Set the annular determinate mode to show task progress.
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"对不起，您的手机没有TouchID功能";
                    // Move to bottm center.
                    hud.offset = CGPointMake(0.f,MBProgressMaxOffset );
                    
                    [hud hideAnimated:YES afterDelay:0.8f];
                }
            }
        }
            break;
        case 1:
        {
            if (row == 1) {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 2:
        {
            if (row == 1) {
               [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 3:
        {
            if (row == 1) {
              [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark THPaySettinCheckCellDelegate
-(void)switchInCellBeTouched:(BOOL)isOn title:(NSString *)title indexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"title = %@",title);
    //更新数据源
    NSMutableArray *arr = [NSMutableArray arrayWithArray:dataSource[indexPath.section][indexPath.row]];
    [arr replaceObjectAtIndex:1 withObject:[NSNumber numberWithBool:isOn]];
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:@[arr,title]];
    [dataSource replaceObjectAtIndex:indexPath.section withObject:arr1];
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    NSMutableArray *arr2 =[NSMutableArray arrayWithArray: dataSource[indexPath.section]];
    if (!isOn) {
        
        [arr2 removeObjectAtIndex:1];
    }
    [dataSource replaceObjectAtIndex:index.section withObject:arr2];
    //更新TabelView
    [self.tableView beginUpdates];
    if (!isOn) {
        [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
        [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self.tableView endUpdates];
}



#pragma mark THFreePWDSettingVCDelegate
-(void)popBackSelectedCount:(NSString *)text
{
    THPaySettingNomalTableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    [cell refreshCellWithTitle:dataSource[selectedIndexPath.section][selectedIndexPath.row] subscriptTitle:text];
}

-(void)useStoreCode:(NSString *)code
{
    NSLog(@"code = %@",code);
//    THForgetPWDViewController *vc = [[THForgetPWDViewController alloc]initWithNibName:@"THForgetPWDViewController" bundle:nil];
//    vc.isVerifyClosePay = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}


-(void)disAction
{
    [self.passwordView removeFromSuperview];
    
}
@end
