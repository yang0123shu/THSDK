//
//  Order.h
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Order : NSObject

/**
 *  订单id
 */
@property (nonatomic)NSString *oid;

/**
 *  交易金额
 */
@property (nonatomic)CGFloat amount;

/**
 *  商品id
 */
@property (nonatomic)NSString *pid;

/**
 *  商品名称
 */
@property (nonatomic)NSString *pname;

/**
 *  商品数量
 */
@property (nonatomic)NSInteger pnum;

/**
 *  下单时间
 */
@property (nonatomic)NSString *buytime;

/**
 *  订单状态
 */
@property (nonatomic)NSString *orderstatus;


+(instancetype)shareOrder;


-(NSString *)toString;





@end
