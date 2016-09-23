//
//  User.h
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSInteger id;

@property (nonatomic) NSString *uname;

@property (nonatomic) NSString *acno;

/**
 *  密码
 */
@property (nonatomic) NSString *password;

/**
 *  联系电话
 */
@property (nonatomic) NSString *tel;

/**
 *  会员id
 */
@property (nonatomic) NSString *memberid;

/**
 *  VIPNO
 */
@property (nonatomic) NSString *vipno;

/**
 *  邮箱
 */
@property (nonatomic) NSString *email;



+(User *)shareUser;

-(NSString *)toString;


@end
