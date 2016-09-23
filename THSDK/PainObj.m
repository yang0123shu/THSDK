//
//  PainObj.m
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "PainObj.h"
#import "THNetworkTool.h"
@implementation PainObj

static PainObj *obj = nil;
+(instancetype)shareObj
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc]init];
    });
    return obj;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _order = [Order shareOrder];
        _user = [User shareUser];
        _transcode = @"";
    }
    return self;
}

-(NSString*)toString
{
    return [NSString stringWithFormat:@"{%@,%@,\"transcode\":\"%@\"}",[_user toString],[_order toString],_transcode];
//    return [THNetworkTool getObjectData:self];
}

@end
