//
//  THBindingCardViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/1.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THBindingCardViewController.h"
#import "THMyShoppingCardViewController.h"
#import "THNetworkTool.h"
#import "PowerEnterUITextField.h"
#import "Masonry.h"
@interface THBindingCardViewController ()
{
    BOOL isAgreeProtocol;
    THNetworkTool *tool;
}
@property (weak, nonatomic) IBOutlet UIView *cardNumView;

@property (weak, nonatomic) IBOutlet UIView *cardPWDView;

@property (weak, nonatomic) IBOutlet UITextField *cardNumTF;

@property (nonatomic) PowerEnterUITextField *cardPWDTF;

@property (weak, nonatomic) IBOutlet UIButton *protocolAgreeBtn;


@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;

@property (weak, nonatomic) IBOutlet UIButton *bindingBtn;


@end

@implementation THBindingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定购物卡";
    _cardNumView.layer.cornerRadius = kBtnCorner;
    _cardPWDView.layer.cornerRadius = kBtnCorner;
    _bindingBtn.layer.cornerRadius = kBtnCorner;
    
    NSString *text = @"我已阅读并同意天虹购物卡使用协议";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:text];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:250/255.0 green:47/255.0 blue:47/255.0 alpha:1] range:NSMakeRange(7, text.length - 7)];
    [attri addAttribute:NSUnderlineStyleAttributeName
                  value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                  range:NSMakeRange(7, text.length - 7)];
    [attri addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithRed:250/255.0 green:47/255.0 blue:47/255.0 alpha:1] range:NSMakeRange(7, text.length - 7)];
    self.protocolLabel.attributedText = attri;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    tool = [THNetworkTool shareTool];
    tool.target = self;
    
    self.cardPWDTF = [[PowerEnterUITextField alloc]init];
    self.cardPWDTF.placeholder = @"请输入购物卡覆膜密码";
    self.cardPWDTF.passwordKeyboardType = Full;           //将键盘设置为全键盘
    //checkPasswordUITextField.font= [UIFont fontWithName:@"Arial" size:18];
    //        tf.isRoundam = YES;//设置键盘按键为随机乱序
    //checkPasswordUITextField.borderStyle=UITextBorderStyleNone;
    self.cardPWDTF.minLength = 6;                         //设置输入最小长度为2
    self.cardPWDTF.maxLength = 12;//设置输入最大长度为7
    
    
    self.cardPWDTF.isHighlightKeybutton = PopupBtn;       //设置不加亮键盘按键
    self.cardPWDTF.valueType = DefaultPassword;
    //    self.PayPWDTF.timestamp = @"aaaaaaaaa";//设置时间戳
    //checkPasswordUITextField.plaintext =@"123456";          //明文接口
    self.cardPWDTF.accepts = @"";//设置可接受的内容，正则表达式
    //checkPasswordUITextField.setCalcFactor = @"123456";
    //checkPasswordUITextField.x98Type = 0;
    self.cardPWDTF.platformPublicKey = kKeyboardPublickey;                                //设置加密平台密钥
    self.cardPWDTF.borderStyle = UITextBorderStyleNone;
//    self.cardPWDTF.delegate = self;
    self.cardPWDTF.doneButtonAction = ^(PowerEnterUITextField *powerEnterUITextField){
        NSLog(@"点击完成按钮，密码密文为：%@",powerEnterUITextField.value);
        
    };
    self.cardPWDTF.inputContentsChanged = ^(PowerEnterUITextField *powerEnterUITextField){
        NSLog(@"已输入密码长度为：%lu",(unsigned long)powerEnterUITextField.text.length);
        
    };
    [self.view addSubview:self.cardPWDTF];
    [self.cardPWDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cardPWDView);
        make.left.right.equalTo(self.cardNumTF);
        make.height.equalTo(self.cardNumTF);
    }];
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isAgreeProtocol = YES;
    //获取密码键盘时间戳
    
    
}

- (IBAction)toBindingShoppingCard:(UIButton *)sender {
    
    
    [tool getTokenBlock:^(NSString *token) {
        [tool POSHttpURL:@"bindCardConfirm" params:@{@"pan":_cardNumTF.text,@"pin_data":_cardPWDTF.value,@"resToken":token} success:^(NSDictionary *result) {
            THMyShoppingCardViewController *vc = [[THMyShoppingCardViewController alloc]initWithNibName:@"THMyShoppingCardViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
    
    
}

- (IBAction)agreeButtonTouched:(UITapGestureRecognizer *)sender {
    isAgreeProtocol = !isAgreeProtocol;
    if (!isAgreeProtocol) {
        [self.protocolAgreeBtn setImage:[UIImage imageNamed:@"icon_box_nocheck"] forState:UIControlStateNormal];
        [self.bindingBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.bindingBtn.enabled = NO;
    }
    else{
        [self.protocolAgreeBtn setImage:[UIImage imageNamed:@"icon_box_check"] forState:UIControlStateNormal];
        [self.bindingBtn setBackgroundColor:[UIColor colorWithRed:253/255.0 green:78/255.0 blue:84/255.0 alpha:1]];
        self.bindingBtn.enabled = YES;
    }
}

- (IBAction)toShowProtocolContent:(UITapGestureRecognizer *)sender {
    NSLog(@"点击用户协议");
}





@end
