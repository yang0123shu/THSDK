//
//  THCryptTool.h
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTMBase64.h"
@interface THCryptTool : NSObject
{
    SecKeyRef publicKey;
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    size_t maxPlainLen;
}
/**
 *  RSA加密
 *
 *  @param sourceData 数据源
 *  @param key        公钥
 *
 *  @return 密文
 */
-(NSString*)RSAEncryptWithData:(NSString*)sourceData;


/**
 *  3DES加密
 *
 *  @param sourceData 数据源
 *  @param key        公钥
 *
 *  @return 密文
 */
-(NSString*)TriDESEncryptWithData:(NSString*)sourceData pulickey:(NSString*)key;

/**
 *  生成条形码
 *
 *  @param code   数据内容
 *  @param width  宽
 *  @param height 高
 *
 *  @return 图片数据
 */
//- (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;
//
//
///**
// *  生成二维码
// *
// *  @param code   数据内容
// *  @param width  宽
// *  @param height 高
// *
// *  @return 图片数据
// */
//- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

/**
 *  生成条形码
 *
 *  @param code            数据内容
 *  @param size            大小
 *  @param color           条形码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 图片
 */
+ (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;

/**
 *  生成二维码
 *
 *  @param string          数据内容
 *  @param size            大小
 *  @param color           二维码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 图片
 */
+ (UIImage *)qrImageWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;


-(void)processCerFile;

@end
