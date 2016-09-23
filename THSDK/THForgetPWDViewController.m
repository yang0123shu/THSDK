//
//  THForgetPWDViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/31.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THForgetPWDViewController.h"
#import "JKCountDownButton.h"
#import "THIdentityVerifyViewController.h"
#import "THStatusReuqestViewController.h"
#import "THNetworkTool.h"
@interface THForgetPWDViewController ()<UITextFieldDelegate>
{
    THNetworkTool *tool;
}

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITextField *VerifyCodeTF;

@property (weak, nonatomic) IBOutlet UIButton *NextBtn;


@end

@implementation THForgetPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tool = [THNetworkTool shareTool];
    tool.target = self;
    self.title = @"修改快捷支付密码";
    self.NextBtn.layer.cornerRadius = kBtnCorner;
//    self.VerifyCodeTF.leftViewMode = UITextFieldViewModeUnlessEditing;
//    UIImageView *leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u246"]];
//    self.VerifyCodeTF.leftView = leftImageView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"获取验证码发送短信至%@",@"186******92"]];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10, 11)];
    _label.attributedText = text;
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isVerifyClosePay) {
        [self.NextBtn setTitle:@"关闭虹支付" forState:UIControlStateNormal];
        self.title = @"虹支付";
    }
    
    
    
    
}


- (IBAction)getVerifyCode:(JKCountDownButton*)sender {
    //获取短信验证码
    [tool getMsgVerifyCode:^(BOOL success) {
        sender.titleLabel.textColor = [UIColor lightGrayColor];
        sender.enabled = NO;
        //button type要 设置成custom 否则会闪动
        [sender startCountDownWithSecond:60];
        
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%zd秒后重发",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            sender.titleLabel.textColor = [UIColor redColor];
            return @"点击重新获取";
            
        }];
    }];
    
}

- (IBAction)toNextStep:(UIButton *)sender {
    if (_isVerifyClosePay) {
        THStatusReuqestViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"THStatusReuqestViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        THIdentityVerifyViewController *vc = [[THIdentityVerifyViewController alloc]initWithNibName:@"THIdentityVerifyViewController" bundle:nil];
        vc.isModifyPWD = YES;
        vc.inputedVerifyCode = self.VerifyCodeTF.text;
        tool.verifyCode = self.VerifyCodeTF.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    self.VerifyCodeTF.leftViewMode = UITextFieldViewModeNever;
    [self.NextBtn setBackgroundColor:kBtnBgColor];
    NSLog(@"textFieldDidBeginEditing");
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length] == 0) {
        [self.NextBtn setBackgroundColor:kBtnBgUnableColor];
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
