//
//  THCodeImageViewController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/18.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THCodeImageViewController.h"

@interface THCodeImageViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *barcodeImageView;


@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;



@end

@implementation THCodeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isBarCode) {
        _barcodeImageView.image = _showImage;
        self.title = @"条形码";
    }
    else{
        _QRCodeImageView.image = _showImage;
        self.title = @"二维码";
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
