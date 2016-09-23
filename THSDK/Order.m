//
//  Order.m
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "Order.h"
#import "THNetworkTool.h"
@implementation Order

static Order *order = nil;
+(instancetype)shareOrder
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        order = [[self alloc]init];
    });
    return order;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _amount = 0;
        _oid = @"";
        _pid = @"";
        _pname = @"";
        _pnum = 0;
        _buytime = @"";
        _orderstatus = @"";
    }
    return self;
}


-(NSString *)floatToString:(CGFloat)floa
{
    
    NSString *str = [NSString stringWithFormat:@"%.2f",floa];
    if ([str rangeOfString:@"."].location == NSNotFound) {
        return str;
    }
    NSRange range = [str rangeOfString:@"."];
    NSString *sub1 = [str substringWithRange:NSMakeRange(0, [str length]-range.location)];
    NSString *sub2 = [str substringWithRange:NSMakeRange(range.location+1, [str length] - range.location -1)];
    
    
    return @"";
}


-(NSString *)toString
{
    return [NSString stringWithFormat:@"{\"id\":%@,\"amount\":%.2f,\"pid\":\"%@\",\"pname\":\"%@\",\"pnum\":%ld,\"buytime\":\"%@\",\"orderstatus\":\"%@\"}",_oid,_amount,_pid,_pname,(long)_pnum,_buytime,_orderstatus];
//    return [NSString stringWithFormat:@"\"order\":{\"id\":%@,\"amount\":%.2f,\"pid\":\"%@\",\"pname\":\"%@\",\"pnum\":%ld,\"buytime\":\"%@\",\"orderstatus\":\"%@\"}",_oid,_amount,_pid,_pname,(long)_pnum,_buytime,_orderstatus];
//    return [THNetworkTool getObjectData:self];
}

@end
