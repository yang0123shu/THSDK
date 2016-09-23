//
//  User.m
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "User.h"
#import "THNetworkTool.h"
@implementation User

static User *user = nil;
+(instancetype)shareUser
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc]init];
    });
    return user;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _id = 0;
        _uname = @"";
        _acno = @"";
        _password = @"";
        _tel = @"";
        _memberid = @"";
        _vipno = @"";
        _email = @"";
    }
    return self;
}


-(NSString *)toString
{
//    return [NSString stringWithFormat:@"User{id=%ld,uname='%@',acno='%@',password='%@',tel='%@',memberid='%@',vipno='%@',email='%@'}",(long)_id,_uname,_acno,_password,_tel,_memberid,_vipno,_email];
    
//    return [NSString stringWithFormat:@"\"user\":{\"acno\":\"%@\",\"tel\":\"%@\"}",_acno,_tel];
    return [NSString stringWithFormat:@"{\"acno\":\"%@\",\"tel\":\"%@\"}",_acno,_tel];
//    return [THNetworkTool getObjectData:self];
}

@end
