//
//  ViewController.m
//  THSDK
//
//  Created by 阳书成 on 16/9/22.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "ViewController.h"
#import "THStatusReuqestViewController.h"
#import "PainObj.h"
@interface ViewController ()
{
    User *u;
    Order *order;
    PainObj *obj;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    u = [User shareUser];
    u.id = 20;
    u.uname = @"jfiew";
    u.password = @"jo";
    u.acno = @"89273";
    u.tel = @"1823878498";
    u.memberid = @"93892";
    u.vipno = @"";
    
    NSLog(@"user = %@",[u toString]);
    
    order = [Order shareOrder];
    order.oid = @"20000";
    order.amount = 3992.03;
    order.pid = @"haha";
    order.pname = @"jofe";
    order.pnum = 300;
    order.buytime = @"2016-09-11 11:02:30";
    NSLog(@"order = %@",[order toString]);
    
    obj = [PainObj shareObj];
    obj.user = u;
    obj.order = order;
    obj.transcode = @"";
    NSLog(@"obj = %@",[obj toString]);
    
    CGFloat f1 = 232;
    NSString *f1str = [NSString stringWithFormat:@"%.2f",f1];
    NSLog(@"f1str = %@",f1str);
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identity = [segue identifier];
    THStatusReuqestViewController *vc = [segue destinationViewController];
    vc.sourceController = self;
    if ([identity isEqualToString:@"toSomeVC"]) {
        obj.transcode = @"authLogin";
        vc.obj = obj;
        vc.afterTransType = TH_APP_SDK_TRANSCODE_MYSHOPPINGCARD;
    }
    else if([identity isEqualToString:@"toLogin"]){
        //        vc.operationtype = TH_OPERATION_TYPE_LOGIN;
        obj.transcode = @"authLogin";
        vc.obj = obj;
        vc.afterTransType = TH_APP_SDK_TRANSCODE_ROOT;
    }
    else if([identity isEqualToString:@"toPay"]){
        //        vc.operationtype = TH_OPERATION_TYPE_PAY;
        obj.transcode = @"authLogin";
        vc.obj = obj;
        vc.afterTransType = TH_APP_SDK_TRANSCODE_PAYCODE;
    }
    else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
