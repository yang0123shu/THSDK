//
//  THShoppingCardDetailViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/1.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THShoppingCardDetailViewController.h"

@interface THShoppingCardDetailViewController ()


@property (weak, nonatomic) IBOutlet UILabel *cardValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *bindingCardDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *validDateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backImage;


@end

@implementation THShoppingCardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物卡详情";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)];
    
    self.backImage.layer.cornerRadius = kBtnCorner;
    self.backImage.backgroundColor = [UIColor colorWithRed:177/255.0 green:44/255.0 blue:86/255.0 alpha:1];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_paramDic[@"cardValue"]]];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(1, attri.string.length - 1)];
    
    _cardValueLabel.attributedText = attri;
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)toBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
