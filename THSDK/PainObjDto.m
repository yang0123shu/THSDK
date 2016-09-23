//
//  PainObjDto.m
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "PainObjDto.h"
#import "THNetworkTool.h"
@implementation PainObjDto

static PainObjDto *objdto = nil;
+(instancetype)shareObjDto
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objdto = [[self alloc]init];
    });
    return objdto;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _painobj = [PainObj shareObj];
        _uniqueId = @"";
    }
    return self;
}

-(NSString *)toString
{
    return [NSString stringWithFormat:@"{\"painObj\":%@,\"uniqueId\":\"%@\"}",[_painobj toString],_uniqueId];
//    return [THNetworkTool getObjectData:self];
}

@end
