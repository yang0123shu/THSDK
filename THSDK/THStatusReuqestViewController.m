//
//  THStatusReuqestViewController.m
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THStatusReuqestViewController.h"
#import "THNetworkTool.h"
#import "PainObjDto.h"
#import "RSAEncryptor.h"
#import "THRootViewController.h"
#import "THOffSolvedViewController.h"
#import "THMyShoppingCardViewController.h"
#import "THPayViewController.h"
@interface THStatusReuqestViewController ()
{
    THNetworkTool *tool;
    PainObjDto *objdto;
    RSAEncryptor *rsa;
}
@end

@implementation THStatusReuqestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询或付款或到功能";
    tool = [THNetworkTool shareTool];
    tool.target = self;
    objdto = [PainObjDto shareObjDto];
    rsa  = [[RSAEncryptor alloc]init];
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    //    NSString *privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    NSLog(@"public key: %@", publicKeyPath);
    [rsa loadPublicKeyFromFile:publicKeyPath];
    
    
    
    
    // Do any additional setup after loading the view.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    if ([_obj.transcode isEqualToString:@"authLogin"]) {
        [tool GETHttpURL:@"generateAccessToken" params:nil success:^(NSDictionary *result) {
            NSString *plainText = result[@"accessToken"][@"uniqueId"];
            objdto.uniqueId = plainText;
            
            NSString *txt = [objdto.painobj.user toString];
            NSLog(@"UserString = %@",txt);
            NSString *encryptStr = [rsa rsaEncryptString:txt];
            [tool POSHttpURL:@"getAccessLoginURLIOS" params:@{@"uEncryptData":encryptStr,@"oEncryptData":[[objdto.painobj.order toString] base64EncodedString],@"tEncryptData":objdto.painobj.transcode,@"uniEncryptData":[rsa rsaEncryptString:objdto.uniqueId]} success:^(NSDictionary *result1) {
                [tool GETHttpURL:@"openPayFunQry" params:nil success:^(NSDictionary *result2) {
                    objdto.painobj.user.acno = result2[@"accno"];
                    NSString *status = result2[@"status"];
                    //已开通虹支付
//                    if ([status isEqualToString:@"1"]) {
//                        //客户端跳转到虹包首页
//                        if (_afterTransType == TH_APP_SDK_TRANSCODE_ROOT) {
//                            THRootViewController *vc = [[THRootViewController alloc]initWithNibName:@"THRootViewController" bundle:nil];
//                            [self.navigationController pushViewController:vc animated:YES];
//                        }
//                        else if (_afterTransType == TH_APP_SDK_TRANSCODE_MYSHOPPINGCARD)
//                        {
//                            //查询账户信息获取我的购物卡列表数据
//                            //获取用户信息，包括购物卡列表
////                            [tool GETHttpURL:@"payFunDetaQry" params:nil success:^(NSDictionary *result) {
////                                
////                            }];
//                            THMyShoppingCardViewController *vc = [[THMyShoppingCardViewController alloc]initWithNibName:@"THMyShoppingCardViewController" bundle:nil];
//                            [self.navigationController pushViewController:vc animated:YES];
//                        }
//                        else if (_afterTransType == TH_APP_SDK_TRANSCODE_PAYCODE)
//                        {
//                            //我的付款码
//                            //获取付款码，跳转到条形码，二维码显示界面
////                            [tool GETHttpURL:@"getUnlineQrCode" params:nil success:^(NSDictionary *result) {
////                                
////                            }];
//                            THPayViewController *vc = [[THPayViewController alloc]initWithNibName:@"THPayViewController" bundle:nil];
//                            [self.navigationController pushViewController:vc animated:YES];
//                        }
//                        
//                    }
                    
                    //测试未开通虹支付
                                        status = @"0";
                                        objdto.painobj.user.tel = @"186******92";
                    
                    
                                        if ([status isEqualToString:@"0"]) {
                                            THOffSolvedViewController *VC = [[THOffSolvedViewController alloc]initWithNibName:@"THOffSolvedViewController" bundle:nil];
                                            VC.phoneNumber = objdto.painobj.user.tel;
                                            [self.navigationController pushViewController:VC animated:YES];
                                        }
                    
                }];
                
            
                
//                [tool getTokenBlock:^(NSString *token) {
//                    [tool POSHttpURL:@"bindCardConfirm" params:@{@"pan":@"78374913274132",@"pin_data":@"fjie83798jfij32",@"resToken":token} success:^(NSDictionary *result3) {
//                        NSLog(@"绑卡回调 = %@",result3);
//                    }];
//                }];
            }];
        }];
    }
    else if([_obj.transcode isEqualToString:@"authPay"])
    {
        
    }
    else{
        
    }
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
