//
//  THSetPWDViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/31.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THSetPWDViewController.h"
#import "THRootViewController.h"
#import "PowerEnterUITextField.h"
#import "THNetworkTool.h"
#import "Masonry.h"
#import "IQKeyboardManager.h"
@interface THSetPWDViewController ()
{
    THNetworkTool *tool;
}
@property (nonatomic)  PowerEnterUITextField *PayPWDTF;

@property (nonatomic)  PowerEnterUITextField *PayPWDConfirmTF;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *payLabel;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;


@end

@implementation THSetPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置交易密码";
    self.confirmBtn.layer.cornerRadius = kBtnCorner;
    self.PayPWDTF.passwordKeyboardType = Number;
    self.PayPWDConfirmTF.passwordKeyboardType = Number;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    tool = [THNetworkTool shareTool];
    tool.target = self;
    [self addTextfields];
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    IQKeyboardManager *mgr = [IQKeyboardManager sharedManager];
    [mgr setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //获取密码键盘时间戳
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    IQKeyboardManager *mgr = [IQKeyboardManager sharedManager];
    [mgr setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

-(void)addTextfields
{
    self.PayPWDTF = [[PowerEnterUITextField alloc]init];
    self.PayPWDTF.passwordKeyboardType = Full;           //将键盘设置为全键盘
    //checkPasswordUITextField.font= [UIFont fontWithName:@"Arial" size:18];
    self.PayPWDTF.isRoundam = YES;//设置键盘按键为随机乱序
    self.PayPWDTF.borderStyle = UITextBorderStyleNone;
    //checkPasswordUITextField.borderStyle=UITextBorderStyleNone;
    self.PayPWDTF.minLength = 6;                         //设置输入最小长度为2
    self.PayPWDTF.maxLength = 12;                        //设置输入最大长度为7
    self.PayPWDTF.font = [UIFont systemFontOfSize:15];
    self.PayPWDTF.placeholder = @"请输入6位数字作为快捷支付密码";
    self.PayPWDTF.isHighlightKeybutton = PopupBtn;       //设置不加亮键盘按键
    self.PayPWDTF.valueType = DefaultPassword;
    //    self.PayPWDTF.timestamp = @"aaaaaaaaa";//设置时间戳
    //checkPasswordUITextField.plaintext =@"123456";          //明文接口
    self.PayPWDTF.accepts = @"";//设置可接受的内容，正则表达式
    //checkPasswordUITextField.setCalcFactor = @"123456";
    //checkPasswordUITextField.x98Type = 0;
    self.PayPWDTF.platformPublicKey = kKeyboardPublickey;                                //设置加密平台密钥
    
    self.PayPWDTF.doneButtonAction = ^(PowerEnterUITextField *powerEnterUITextField){
        NSLog(@"点击完成按钮，密码密文为：%@",powerEnterUITextField.value);
    };
    self.PayPWDTF.inputContentsChanged = ^(PowerEnterUITextField *powerEnterUITextField){
        NSLog(@"已输入密码长度为：%lu",(unsigned long)powerEnterUITextField.text.length);
        
    };
    [self.view addSubview:self.PayPWDTF];
    
    self.PayPWDConfirmTF = [[PowerEnterUITextField alloc]init];
    self.PayPWDConfirmTF.passwordKeyboardType = Full;           //将键盘设置为全键盘
    self.PayPWDConfirmTF.borderStyle = UITextBorderStyleNone;
    //checkPasswordUITextField.font= [UIFont fontWithName:@"Arial" size:18];
    self.PayPWDConfirmTF.isRoundam = YES;//设置键盘按键为随机乱序
    //checkPasswordUITextField.borderStyle=UITextBorderStyleNone;
    self.PayPWDConfirmTF.minLength = 6;                         //设置输入最小长度为2
    self.PayPWDConfirmTF.maxLength = 12;                        //设置输入最大长度为7
    self.PayPWDConfirmTF.placeholder = @"请重复输入支付密码";
    self.PayPWDConfirmTF.font = [UIFont systemFontOfSize:15];
    self.PayPWDConfirmTF.isHighlightKeybutton = PopupBtn;       //设置不加亮键盘按键
    self.PayPWDConfirmTF.valueType = DefaultPassword;
    //    self.PayPWDTF.timestamp = @"aaaaaaaaa";//设置时间戳
    //checkPasswordUITextField.plaintext =@"123456";          //明文接口
    self.PayPWDConfirmTF.accepts = @"";//设置可接受的内容，正则表达式
    //checkPasswordUITextField.setCalcFactor = @"123456";
    //checkPasswordUITextField.x98Type = 0;
    self.PayPWDConfirmTF.platformPublicKey = kKeyboardPublickey;                                //设置加密平台密钥
    
    self.PayPWDConfirmTF.doneButtonAction = ^(PowerEnterUITextField *powerEnterUITextField){
        NSLog(@"点击完成按钮，密码密文为：%@",powerEnterUITextField.value);
    };
    self.PayPWDConfirmTF.inputContentsChanged = ^(PowerEnterUITextField *powerEnterUITextField){
        NSLog(@"已输入密码长度为：%lu",(unsigned long)powerEnterUITextField.text.length);
        
    };
    [self.view addSubview:self.PayPWDConfirmTF];
    
    
    [self.PayPWDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payLabel.mas_right);
        make.centerY.equalTo(self.payLabel);
        make.right.equalTo(self.view1).offset(-8);
    }];
    [self.PayPWDConfirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.confirmLabel.mas_right);
        make.centerY.equalTo(self.confirmLabel);
        make.right.equalTo(self.view2).offset(-8);
    }];
}




- (IBAction)toConfirm:(UIButton *)sender {
    //发送修改请求
//    [tool POSHttpURL:@"resetTrsPwdConfirm" params:@{@"pin_data":_PayPWDConfirmTF.value,@"sms_code":_verifycode} success:^(NSDictionary *result) {
//        THRootViewController *vc = [[THRootViewController alloc]initWithNibName:@"THRootViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
    
    [tool getTokenBlock:^(NSString *token) {
        [tool POSHttpURL:@"resetTrsPwdConfirm" params:@{@"pin_data":self.PayPWDConfirmTF.value,@"sms_code":tool.verifyCode} success:^(NSDictionary *result) {
            THRootViewController *vc = [[THRootViewController alloc]initWithNibName:@"THRootViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
    
    
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
