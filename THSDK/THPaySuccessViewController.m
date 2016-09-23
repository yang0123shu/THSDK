//
//  THPaySuccessViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/7.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THPaySuccessViewController.h"

@interface THPaySuccessViewController ()

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@end

@implementation THPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款";
    self.finishBtn.layer.cornerRadius = kBtnCorner;
    self.finishBtn.layer.borderWidth = 1;
    self.finishBtn.layer.borderColor = (__bridge CGColorRef _Nullable)(kBtnBgColor);
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

@end
