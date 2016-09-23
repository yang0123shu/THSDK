//
//  THStopPayCodeViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/5.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THStopPayCodeViewController.h"
#import "THForgetPWDViewController.h"
@interface THStopPayCodeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *noteLabel;


@property (weak, nonatomic) IBOutlet UITextField *pwdTF;




@end

@implementation THStopPayCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)forgetPWD:(UIButton *)sender {
    THForgetPWDViewController *vc = [[THForgetPWDViewController alloc]initWithNibName:@"THForgetPWDViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isStoppingPaycode) {
        _noteLabel.text = @"输入支付密码关闭付款码";
    }
    else{
        _noteLabel.text = @"输入支付密码开启付款码";
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
