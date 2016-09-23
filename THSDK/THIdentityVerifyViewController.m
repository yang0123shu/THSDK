//
//  THIdentityVerifyViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THIdentityVerifyViewController.h"
#import "THRootViewController.h"
//#import "SVProgressHUD.h"
#import "THSetPWDViewController.h"
#import "THStatusReuqestViewController.h"
@interface THIdentityVerifyViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *identityTF;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;


@end

@implementation THIdentityVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"u318"] style:UIBarButtonItemStyleDone target:self action:@selector(turnback)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn setImage:[UIImage imageNamed:@"u318"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(turnback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // Do any additional setup after loading the view from its nib.
}

-(void)turnback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)toVerifyIdentity:(id)sender
{
//    [SVProgressHUD showWithStatus:@"身份验证中..."];
//    //    [SVProgressHUD dismissWithDelay:2];
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 9), ^{
//        [SVProgressHUD dismiss];
//        
//        
//    });
    
    if (_isModifyPWD) {
        THSetPWDViewController *vc = [[THSetPWDViewController alloc]initWithNibName:@"THSetPWDViewController" bundle:nil];
        vc.verifycode = self.inputedVerifyCode;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        THRootViewController *vc = [[THRootViewController alloc]initWithNibName:@"THRootViewController" bundle:nil];
        vc.lastVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"THStatusReuqestViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.nameTF.text length] != 0 && textField == self.identityTF) {
        [self.finishBtn setBackgroundColor:kBtnBgColor];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.nameTF.text length] == 0 || [self.identityTF.text length] == 0 ) {
        [self.finishBtn setBackgroundColor:kBtnBgUnableColor];
    }
    return YES;
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
