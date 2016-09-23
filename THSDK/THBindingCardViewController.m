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
@interface THBindingCardViewController ()
{
    BOOL isAgreeProtocol;
    THNetworkTool *tool;
}
@property (weak, nonatomic) IBOutlet UIView *cardNumView;

@property (weak, nonatomic) IBOutlet UIView *cardPWDView;

@property (weak, nonatomic) IBOutlet UITextField *cardNumTF;

@property (weak, nonatomic) IBOutlet UITextField *cardPWDTF;

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
}

- (IBAction)toBindingShoppingCard:(UIButton *)sender {
    
    
    [tool getTokenBlock:^(NSString *token) {
        [tool POSHttpURL:@"bindCardConfirm" params:@{@"pan":@"83749179234",@"pin_data":@"u9jf9832fih32i",@"resToken":token} success:^(NSDictionary *result) {
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
