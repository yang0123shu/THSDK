//
//  THOffSolvedViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THOffSolvedViewController.h"
//#import "SVProgressHUD.h"
#import "THIdentityVerifyViewController.h"
#import "JKCountDownButton.h"
#import "Masonry.h"
#import "PowerEnterUITextField.h"
#import "THNetworkTool.h"
@interface THOffSolvedViewController ()
{
    __block NSInteger secondeTime;
    NSTimer *timer;
    NSString *verifycode;
    THNetworkTool *nettool;
    
}
@property (nonatomic)  PowerEnterUITextField *PayPWDTF;
@property (nonatomic)  PowerEnterUITextField *PayPWDConfirmTF;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLable;
@property (weak, nonatomic) IBOutlet UITextField *VerifyCodeTF;

@property (weak, nonatomic) IBOutlet UIButton *OnLockPayBtn;

@property (weak, nonatomic) IBOutlet JKCountDownButton *GetVerifyCodeBtn;


@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UILabel *payLabel;

@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;


@end

@implementation THOffSolvedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"虹支付";
    self.OnLockPayBtn.layer.cornerRadius = kBtnCorner;
    
    nettool = [THNetworkTool shareTool];
    nettool.target = self;
    
    
    self.PayPWDTF = [[PowerEnterUITextField alloc]init];
    self.PayPWDTF.passwordKeyboardType = Full;           //将键盘设置为全键盘
    //checkPasswordUITextField.font= [UIFont fontWithName:@"Arial" size:18];
    self.PayPWDTF.isRoundam = YES;//设置键盘按键为随机乱序
    //checkPasswordUITextField.borderStyle=UITextBorderStyleNone;
    self.PayPWDTF.minLength = 6;                         //设置输入最小长度为2
    self.PayPWDTF.maxLength = 12;                        //设置输入最大长度为7
    self.PayPWDTF.placeholder = @"请输入8-18位字母或数字";
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
    //checkPasswordUITextField.font= [UIFont fontWithName:@"Arial" size:18];
    self.PayPWDConfirmTF.isRoundam = YES;//设置键盘按键为随机乱序
    //checkPasswordUITextField.borderStyle=UITextBorderStyleNone;
    self.PayPWDConfirmTF.minLength = 6;                         //设置输入最小长度为2
    self.PayPWDConfirmTF.maxLength = 12;                        //设置输入最大长度为7
    self.PayPWDConfirmTF.placeholder = @"请重复输入支付密码";
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
    
    
    
    
    
//    self.VerifyCodeTF.leftViewMode = UITextFieldViewModeUnlessEditing;
//    UIImageView *leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u246"]];
//    self.VerifyCodeTF.leftView = leftImageView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    [self addObserver:self forKeyPath:@"self.VerifyCodeTF.text.length" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew |NSKeyValueObservingOptionPrior context:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    NSLog(@"key = %lu",(unsigned long)options);
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"获取验证码发送短信至%@",self.phoneNumber]];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10, 11)];
    _phoneNumberLable.attributedText = text;
    secondeTime = 59;
    verifycode = @"asdf";
    [nettool getTokenBlock:^(NSString *token) {
        self.PayPWDTF.timestamp = token;
        self.PayPWDConfirmTF.timestamp = token;
        nettool.token = token;
    }];
    
}




- (IBAction)getVerifyCode:(JKCountDownButton*)sender {
//    self.GetVerifyCodeBtn.enabled = NO;
//    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateGetVerifyCodeBtnTitle) userInfo:nil repeats:YES];
//    [timer fire];
    [nettool getMsgVerifyCode:^(BOOL success) {
        if (success) {
            sender.titleLabel.textColor = [UIColor lightGrayColor];
            [sender setTintColor:[UIColor lightGrayColor]];
            sender.enabled = NO;
            //button type要 设置成custom 否则会闪动
            [sender startCountDownWithSecond:60];
            
            [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"%zd秒后重发",second];
                return title;
            }];
            [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                [sender setTintColor:[UIColor redColor]];
                sender.titleLabel.textColor = [UIColor redColor];
                return @"点击重新获取";
                
            }];
        }
    }];
    
 

}

-(void)updateGetVerifyCodeBtnTitle
{
    secondeTime = secondeTime - 1;
    [self.GetVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%.2ld秒",(long)secondeTime] forState:UIControlStateNormal];
    if (secondeTime == 0) {
        [self.GetVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        
    }
}


- (IBAction)toOnlockHongPay:(id)sender {
    if (![_PayPWDTF.text isEqualToString:_PayPWDConfirmTF.text]) {
//        [SVProgressHUD showErrorWithStatus:@"抱歉，您输入的密码不一致"];
    }
    
    else{
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"qwertyu" forKey:@"pin_data"];
        [dic setValue:nettool.token forKey:@"resToken"];
        [nettool POSHttpURL:@"openPayFunConfirm" params:dic success:^(NSDictionary *result){
            
            THIdentityVerifyViewController *vc = [[THIdentityVerifyViewController alloc]initWithNibName:@"THIdentityVerifyViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        
        
    }
}



#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    self.VerifyCodeTF.leftViewMode = UITextFieldViewModeNever;
//    NSLog(@"textFieldDidBeginEditing");
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 1 || [string isEqualToString:@""] || string != nil) {
        self.OnLockPayBtn.enabled = YES;
        self.OnLockPayBtn.backgroundColor = kBtnBgColor;
    }
    else{
        self.OnLockPayBtn.enabled = NO;
        self.OnLockPayBtn.backgroundColor = kBtnBgUnableColor;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    if (textField.text.length == 0) {
        self.OnLockPayBtn.enabled = NO;
        self.OnLockPayBtn.backgroundColor = kBtnBgUnableColor;
    }
    return YES;
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
