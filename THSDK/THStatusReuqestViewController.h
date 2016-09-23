//
//  THStatusReuqestViewController.h
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Order.h"
#import "PainObj.h"

typedef NS_ENUM(NSInteger,TH_APP_SDK_TRANSCODE) {
    TH_APP_SDK_TRANSCODE_ROOT = 0,//默认登录到虹包首页
    TH_APP_SDK_TRANSCODE_MYSHOPPINGCARD,//我的购物卡
    TH_APP_SDK_TRANSCODE_BUYSHOPPINGCARD,//购买购物卡
    TH_APP_SDK_TRANSCODE_PAYCODE,//我的付款码
};



typedef NS_ENUM(NSInteger, TH_OPERATION_TYPE) {
    TH_OPERATION_TYPE_LOGIN = 0,
    TH_OPERATION_TYPE_PAY,
    TH_OPERATION_TYPE_OTHERVC,
};

@interface THStatusReuqestViewController : UIViewController


@property (nonatomic)User *currentUser;
@property (nonatomic)Order *currentOrder;
@property (nonatomic)TH_OPERATION_TYPE operationtype;
@property (nonatomic)NSString *destinationVCName;





@property (nonatomic)UIViewController *sourceController;//app客户端跳转的VC

@property (nonatomic)TH_APP_SDK_TRANSCODE afterTransType;

@property (nonatomic)PainObj *obj;


@end
