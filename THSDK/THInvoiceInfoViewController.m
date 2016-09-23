//
//  THInvoiceInfoViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/13.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THInvoiceInfoViewController.h"

@interface THInvoiceInfoViewController ()
{
    NSInteger selectOption;
}

@property (weak, nonatomic) IBOutlet UIView *infoView1;

@property (weak, nonatomic) IBOutlet UIView *infoView2;

@property (weak, nonatomic) IBOutlet UIView *infoView3;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UITextField *locationInfoTF;

@property (weak, nonatomic) IBOutlet UITextField *personalNameTF;

@property (weak, nonatomic) IBOutlet UIButton *normalBtn;

@property (weak, nonatomic) IBOutlet UIButton *presentBtn;

@property (weak, nonatomic) IBOutlet UIButton *otherBtn;

@end

@implementation THInvoiceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = kBtnCorner;
    self.title = @"发票信息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    selectOption = 1;
}

- (IBAction)toChangeInvoice:(UISwitch *)sender {
    if (!sender.on) {
        self.infoView1.hidden = YES;
        self.infoView2.hidden = YES;
        self.infoView3.hidden = YES;
        self.confirmBtn.hidden = YES;
    }
    else{
        self.infoView1.hidden = NO;
        self.infoView2.hidden = NO;
        self.infoView3.hidden = NO;
        self.confirmBtn.hidden = NO;
    }
}

- (IBAction)toAccessLocation:(UITapGestureRecognizer *)sender {
    
}
- (IBAction)toChooseOption:(UITapGestureRecognizer *)sender {
    NSInteger tag = sender.view.tag;
    switch (tag) {
        case 101:
        {
            [self.normalBtn setImage:[UIImage imageNamed:@"u124"] forState:UIControlStateNormal];
            [self.presentBtn setImage:[UIImage imageNamed:@"u126"] forState:UIControlStateNormal];
            [self.otherBtn setImage:[UIImage imageNamed:@"u126"] forState:UIControlStateNormal];
            selectOption = 1;
        }
            break;
        case 102:
        {
            [self.normalBtn setImage:[UIImage imageNamed:@"u126"] forState:UIControlStateNormal];
            [self.presentBtn setImage:[UIImage imageNamed:@"u124"] forState:UIControlStateNormal];
            [self.otherBtn setImage:[UIImage imageNamed:@"u126"] forState:UIControlStateNormal];
            selectOption = 2;
        }
            break;
        case 103:
        {
            [self.normalBtn setImage:[UIImage imageNamed:@"u126"] forState:UIControlStateNormal];
            [self.presentBtn setImage:[UIImage imageNamed:@"u126"] forState:UIControlStateNormal];
            [self.otherBtn setImage:[UIImage imageNamed:@"u124"] forState:UIControlStateNormal];
            selectOption = 3;
        }
            break;
        default:
            break;
    }
    
    
    
}

@end
