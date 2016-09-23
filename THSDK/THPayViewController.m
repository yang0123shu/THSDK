//
//  THPayViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/1.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THPayViewController.h"
#import "THPaySettingViewController.h"
#import "ViewController.h"
#import "THNetworkTool.h"
#import "THCryptTool.h"
#import "THBindingCardViewController.h"
#import "THBuyShoppingCardViewController.h"
@interface THPayViewController ()
{
    THNetworkTool *tool;
}

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;

@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (weak, nonatomic) IBOutlet UILabel *barNumLabel;

@property (weak, nonatomic) IBOutlet UIImageView *barcodeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImageView;

@end

@implementation THPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:kPayNaviBgColor];
    self.view.backgroundColor = kPayNaviBgColor;
//    self.navigationController.navigationBar.translucent = NO;
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"购物卡支付";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_rainbow_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(paysetting)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    
    tool = [THNetworkTool shareTool];
    tool.target = self;
    
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.cornerRadius = 10;
    self.cardTypeLabel.layer.masksToBounds = YES;
    self.cardTypeLabel.layer.cornerRadius = 10;
    self.leftView.layer.masksToBounds = YES;
    self.leftView.layer.cornerRadius = 10;
    self.rightView.layer.masksToBounds = YES;
    self.rightView.layer.cornerRadius = 10;
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    //    [self.navigationController popViewControllerAnimated:YES];
//    if (_lastVC) {
//        //        [self.navigationController popToViewController:_lastVC animated:YES];
//        [self.navigationController pushViewController:_lastVC animated:YES];
//    }
//    else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)paysetting
{
    THPaySettingViewController *vc = [[THPaySettingViewController alloc]initWithNibName:@"THPaySettingViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toTieShoppingCard:(id)sender {
    THBindingCardViewController *vc = [[THBindingCardViewController alloc]initWithNibName:@"THBindingCardViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toBuyShoppingCard:(id)sender {
    THBuyShoppingCardViewController *vc = [[THBuyShoppingCardViewController alloc]initWithNibName:@"THBuyShoppingCardViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tool GETHttpURL:@"getUnlineQrCode" params:nil success:^(NSDictionary *result) {
        NSString *pcode = result[@"pcode"];
        if (![pcode isEqualToString:@""] || pcode != nil) {
            self.barcodeImageView.image = [THCryptTool generateBarCode:pcode size:self.barcodeImageView.frame.size color:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
            self.qrcodeImageView.image = [THCryptTool qrImageWithString:pcode size:self.qrcodeImageView.frame.size color:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
        }
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
