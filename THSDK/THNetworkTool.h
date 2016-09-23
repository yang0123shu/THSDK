//
//  THNetworkTool.h
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "DLLoginAttri.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "Base64.h"
typedef void(^THNetworksuccess)(NSDictionary * result);
typedef void(^backToken)(NSString*token);
typedef void(^GetVerifyCodeSuccess)(BOOL success);
@interface THNetworkTool : NSObject
{
//    DLLoginAttri *_loginAtt;
    NSMutableDictionary *_responseDic;
    NSString *_exceptionMessage;
    AppDelegate *_dele;
    NSString *_sessionID;
}
@property (nonatomic)NSString *sessionID;

@property (nonatomic)NSString *token;

/**
 *  短信验证码
 */
@property (nonatomic)NSString *verifyCode;

/**
 *  用于目标视图控制器处理错误信息等特殊事件
 */
@property (nonatomic)UIViewController *target;

/**
 *  单例
 *
 *  @return 返回一个对象
 */
+(instancetype)shareTool;


/**
 *  获取token,避免表单重复提交,发送post请求，添加token的key是“resToken”；
 *
 *  @param block 返回token
 */
-(void)getTokenBlock:(backToken)block;

/**
 *  获取短信验证码
 */
-(void)getMsgVerifyCode:(GetVerifyCodeSuccess)block;


/**
 *  获取时间戳
 *
 *  @param block 返回时间戳
 */
-(void)getTimeStamp:(backToken)block;


/**
 *  用于GET请求
 *
 *  @param urlString 地址
 *  @param success   请求成功返回
 */
-(void)GETHttpURL:(NSString*)urlString params:(NSDictionary*)paramDic success:(THNetworksuccess)success;

/**
 *  用于POST请求
 *
 *  @param urlString 地址
 *  @param paramDic  请求体字典
 *  @param success   请求成功返回
 */
-(void)POSHttpURL:(NSString*)urlString params:(NSDictionary*)paramDic success:(THNetworksuccess)success;


+ (NSString*)getObjectData:(id)obj;

@end
