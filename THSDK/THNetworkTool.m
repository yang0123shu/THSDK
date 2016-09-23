//
//  THNetworkTool.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THNetworkTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#import "JSONKit.h"
#import <UIKit/UIKit.h>
//#import "SVProgressHUD.h"

@implementation THNetworkTool
@synthesize sessionID;
static THNetworkTool *tool = nil;
+(instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc]init];
    });
    return tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dele = [UIApplication sharedApplication].delegate;
    }
    return self;
}

//避免表单重复提交
//发送post请求，添加token的key是“resToken”；
-(void)getTokenBlock:(backToken)block
{
    [self GETHttpURL:@"genToken" params:nil success:^(NSDictionary *result) {
        block(result[@"resubmitToken"][@"uniqueId"]);
    }];
}

-(void)getMsgVerifyCode:(GetVerifyCodeSuccess)block{
    [self GETHttpURL:@"getSmsToken" params:nil success:^(NSDictionary *result) {
        block(YES);
    }];
}

-(void)getTimeStamp:(backToken)block
{
    [self GETHttpURL:@"getTimestamp" params:nil success:^(NSDictionary *result) {
        block(result[@"timestamp"]);
    }];
}

-(void)GETHttpURL:(NSString*)transcode params:(NSDictionary*)paramDic success:(THNetworksuccess)success
{
    AFHTTPSessionManager *httpMgr = [AFHTTPSessionManager manager];
    [httpMgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    httpMgr.requestSerializer.timeoutInterval = 10.f;
    [httpMgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [httpMgr.requestSerializer setValue:@"BES-MOBILE-EBANK.ANDROID" forHTTPHeaderField:@"User-Agent"];
    [httpMgr.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [httpMgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [httpMgr.requestSerializer setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [httpMgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept-Language"];
    [httpMgr.requestSerializer setValue:_sessionID forHTTPHeaderField:@"Cookie"];
    [httpMgr.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [httpMgr.requestSerializer setValue:@"15" forHTTPHeaderField:@"ContentLength"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_dele.window animated:YES];
    hud.label.text = @"加载中";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *url = @"";
    if ([transcode isEqualToString:@"generateAccessToken"]) {
        url = GET(transcode);
    }
    else{
        url = POST(transcode);
    }
    NSLog(@"GET: %@",url);
    [httpMgr GET:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [hud hideAnimated:YES];
//        NSLog(@"session response = %@",task.response);
        NSLog(@"responseObject [%@] = %@",transcode,responseObject);
        NSDictionary *res = [responseObject valueForKey:@"res"];
        if ([res[@"status"] isEqualToString:@"0000"]) {
            success(res[@"dataMap"]);
        }
        else{
            NSLog(@"msg:%@",res[@"errmsg"]);
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
            hud.animationType = MBProgressHUDAnimationZoomIn;
            hud.bezelView.color = [UIColor lightGrayColor];
            // Set the annular determinate mode to show task progress.
            hud.mode = MBProgressHUDModeText;
            hud.label.text = res[@"errmsg"];
            // Move to bottm center.
            hud.offset = CGPointMake(0.f,MBProgressMaxOffset );
            
            [hud hideAnimated:YES afterDelay:1.0f];
        }
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:POST(transcode)]];
        for (NSHTTPCookie *cookie in cookies) {
            if ([cookie.name isEqualToString:@"JSESSIONID"]) {
//                NSLog(@"获取sessionid = %@",cookie.value);
                _sessionID = [NSString stringWithFormat:@"JSESSIONID=%@",cookie.value];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error.description);
        
        [hud hideAnimated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
        hud.animationType = MBProgressHUDAnimationZoomIn;
        hud.bezelView.color = [UIColor lightGrayColor];
        // Set the annular determinate mode to show task progress.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络请求失败";
        // Move to bottm center.
        hud.offset = CGPointMake(0.f,MBProgressMaxOffset );
        
        [hud hideAnimated:YES afterDelay:0.8f];
    }];
}



-(void)POSHttpURL:(NSString*)transcode params:(NSDictionary*)paramDic success:(THNetworksuccess)success
{
    AFHTTPSessionManager *httpMgr = [AFHTTPSessionManager manager];
    NSLog(@"发送sessionid = %@",_sessionID);
    [httpMgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    httpMgr.requestSerializer.timeoutInterval = 10.f;
    [httpMgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [httpMgr.requestSerializer setValue:@"BES-MOBILE-EBANK.ANDROID" forHTTPHeaderField:@"User-Agent"];
    //    [httpMgr.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [httpMgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [httpMgr.requestSerializer setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [httpMgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept-Language"];
    [httpMgr.requestSerializer setValue:_sessionID forHTTPHeaderField:@"Cookie"];
    [httpMgr.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [httpMgr.requestSerializer setValue:@"15" forHTTPHeaderField:@"ContentLength"];
    
    //    httpMgr.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"text/html", nil];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_dele.window animated:YES];
    hud.label.text = @"加载中";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"POST %@",POST(transcode));
    [httpMgr POST:POST(transcode) parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"responseObject [%@] = %@",transcode,responseObject);
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:POST(transcode)]];
        for (NSHTTPCookie *cookie in cookies) {
            if ([cookie.name isEqualToString:@"JSESSIONID"]) {
                
                _sessionID = [NSString stringWithFormat:@"JSESSIONID=%@",cookie.value];
            }
        }
        NSDictionary *res = [responseObject valueForKey:@"res"];
        if ([res[@"status"] isEqualToString:@"0000"]) {
            success(res[@"dataMap"]);
        }
        else{
            NSLog(@"msg:%@",res[@"errmsg"]);
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
            hud.animationType = MBProgressHUDAnimationZoomIn;
            hud.bezelView.color = [UIColor lightGrayColor];
            // Set the annular determinate mode to show task progress.
            hud.mode = MBProgressHUDModeText;
            hud.label.text = res[@"errmsg"];
            // Move to bottm center.
            hud.offset = CGPointMake(0.f,MBProgressMaxOffset );
            
            [hud hideAnimated:YES afterDelay:1.0f];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error = %@",error.description);
        
        [hud hideAnimated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
        hud.animationType = MBProgressHUDAnimationZoomIn;
        hud.bezelView.color = [UIColor lightGrayColor];
        // Set the annular determinate mode to show task progress.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络请求失败";
        // Move to bottm center.
        hud.offset = CGPointMake(0.f,MBProgressMaxOffset );
        
        [hud hideAnimated:YES afterDelay:1.3f];
    }];
}



+ (NSString*)getObjectData:(id)obj
{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        unsigned int propsCount;
        objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
        for(int i = 0;i < propsCount; i++)
        {
            objc_property_t prop = props[i];
    
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
            id value = [obj valueForKey:propName];//kvc读值
            if(value == nil)
            {
                value = [NSNull null];
            }
            else
            {
                value = [self getObjectInternal:value];//自定义处理数组，字典，其他类
            }
            [dic setObject:value forKey:propName];
        }
//        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *str = [dic JSONString];
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//        return  [str stringByReplacingOccurrencesOfString:@"\" withString:@""];
    return str1;
    
    
    
//    NSString *className = NSStringFromClass([obj class]);
//    
//    const void *cClassName = [className UTF8String];
//    
//    id theClass = objc_getClass(cClassName);
//    
//    unsigned int outCount, i;
//    
//    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
//    
//    NSMutableArray *propertyNames = [[NSMutableArray alloc] initWithCapacity:1];
//    
//    for (i = 0; i < outCount; i++)
//    {
//        
//        objc_property_t property = properties[i];
//        
//        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        
//        [propertyNames addObject:propertyNameString];
//        
////        [propertyNameString release];
//        
//    }
//    
//    NSMutableDictionary *finalDict = [[NSMutableDictionary alloc] initWithCapacity:1];
//    
//    for(NSString *key in propertyNames)
//    {
//        //        SEL selector = NSSelectorFromString(key);
//        //        id value = [theObject performSelector:selector];
//        id value = [theObject valueForKey:key];//这是修改过的
//        
//        if (value == nil)
//        {
//            value = [NSNull null];
//        }
//        
//        [finalDict setObject:value forKey:key];
//    }
//    
//    
//    NSString *retString = [finalDict JSONString];
//    
////    [propertyNames release];
////    
////    [finalDict release];
//    
//    return retString;
    
    
    
}

+(id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}


@end
