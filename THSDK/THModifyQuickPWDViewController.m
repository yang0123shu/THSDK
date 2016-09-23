//
//  THModifyQuickPWDViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/31.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THModifyQuickPWDViewController.h"
#import "THForgetPWDViewController.h"
#import "PowerEnterUITextField.h"
#import "THNetworkTool.h"
#import "Masonry.h"
#import "IQKeyboardManager.h"
@interface THModifyQuickPWDViewController ()<UITextFieldDelegate>
{
    THNetworkTool *tool;
}
@property (nonatomic)  PowerEnterUITextField *originalPWDTF;

@property (nonatomic)  PowerEnterUITextField *PWDTF;

@property (nonatomic)  PowerEnterUITextField *confirmPWDTF;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;
@end

@implementation THModifyQuickPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改快捷支付密码";
    self.doneBtn.layer.cornerRadius = kBtnCorner;
    self.view1.layer.cornerRadius = kBtnCorner;
    self.view2.layer.cornerRadius = kBtnCorner;
    self.view3.layer.cornerRadius = kBtnCorner;
    tool = [THNetworkTool shareTool];
    tool.target = self;
    [self addTextfields];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    // Do any additional setup after loading the view from its nib.
}


-(void)addTextfields
{
    for (int i = 10;i < 13; i++) {
        PowerEnterUITextField *tf = [[PowerEnterUITextField alloc]init];
        tf.passwordKeyboardType = Full;           //将键盘设置为全键盘
        //checkPasswordUITextField.font= [UIFont fontWithName:@"Arial" size:18];
//        tf.isRoundam = YES;//设置键盘按键为随机乱序
        //checkPasswordUITextField.borderStyle=UITextBorderStyleNone;
        tf.minLength = 6;                         //设置输入最小长度为2
        tf.maxLength = 12;//设置输入最大长度为7
        
        
        tf.isHighlightKeybutton = PopupBtn;       //设置不加亮键盘按键
        tf.valueType = DefaultPassword;
        //    self.PayPWDTF.timestamp = @"aaaaaaaaa";//设置时间戳
        //checkPasswordUITextField.plaintext =@"123456";          //明文接口
        tf.accepts = @"";//设置可接受的内容，正则表达式
        //checkPasswordUITextField.setCalcFactor = @"123456";
        //checkPasswordUITextField.x98Type = 0;
        tf.platformPublicKey = kKeyboardPublickey;                                //设置加密平台密钥
        tf.borderStyle = UITextBorderStyleNone;
        tf.delegate = self;
        tf.doneButtonAction = ^(PowerEnterUITextField *powerEnterUITextField){
            NSLog(@"点击完成按钮，密码密文为：%@",powerEnterUITextField.value);
            [tool getTokenBlock:^(NSString *token) {
                [tool POSHttpURL:@"trsPwdValidate" params:@{@"pin_data":powerEnterUITextField.value,@"resToken":token} success:^(NSDictionary *result) {
                    
                }];
            }];
        };
        tf.inputContentsChanged = ^(PowerEnterUITextField *powerEnterUITextField){
            NSLog(@"已输入密码长度为：%lu",(unsigned long)powerEnterUITextField.text.length);
            
        };
        if (i == 10) {
            tf.placeholder = @"请输入当前支付密码";
            self.originalPWDTF = tf;
        }else if (i == 11)
        {
            tf.placeholder = @"请设置新的支付密码";
            self.PWDTF = tf;
        }
        else if(i == 12){
            tf.placeholder = @"请确认新的支付密码";
            self.confirmPWDTF = tf;
        }
        [self.view addSubview:tf];
    }
    
    
    [self.originalPWDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view1.mas_left).offset(10);
        make.right.equalTo(self.view1.mas_right).offset(-10);
        make.centerY.equalTo(self.view1);
        make.height.equalTo(self.view1.mas_height);
    }];
    [self.PWDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view2.mas_left).offset(10);
        make.right.equalTo(self.view2.mas_right).offset(-10);
        make.centerY.equalTo(self.view2);
        make.height.equalTo(self.view2.mas_height);
    }];
    [self.confirmPWDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view3.mas_left).offset(10);
        make.right.equalTo(self.view3.mas_right).offset(-10);
        make.centerY.equalTo(self.view3);
        make.height.equalTo(self.view3.mas_height);
    }];
    
    

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


- (IBAction)forgetPWD:(id)sender {
    
    
    
    
    THForgetPWDViewController *vc = [[THForgetPWDViewController alloc]initWithNibName:@"THForgetPWDViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toCompleteModify:(UIButton *)sender {
//    [tool POSHttpURL:@"modifyTrsPwdConfirm" params:@{@"":self.originalPWDTF.value,@"":self.confirmPWDTF.value} success:^(NSDictionary *result) {
//        
//    }];
    [tool getTokenBlock:^(NSString *token) {
        [tool POSHttpURL:@"modifyTrsPwdConfirm" params:@{@"pin_data":self.originalPWDTF.value,@"new_pin":self.confirmPWDTF.value,@"resToken":token} success:^(NSDictionary *result) {
            [self toBack];
        }];
    }];
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.confirmPWDTF && textField.text.length != 0 && self.originalPWDTF.text.length != 0 && self.PWDTF.text.length != 0) {
        self.doneBtn.enabled = YES;
        self.doneBtn.backgroundColor = kBtnBgColor;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.confirmPWDTF && textField.text.length != 0 && self.originalPWDTF.text.length != 0 && self.PWDTF.text.length != 0) {
        self.doneBtn.enabled = YES;
        self.doneBtn.backgroundColor = kBtnBgColor;
    }
    else{
        self.doneBtn.enabled = NO;
        self.doneBtn.backgroundColor = kBtnBgUnableColor;
    }
    return YES;
}

@end
