//
//  THCryptTool.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THCryptTool.h"
//#import "x509.h"
#import <Security/Security.h>
#import "RSAEncryptor.h"
@implementation THCryptTool


-(NSString*)RSAEncryptWithData:(NSString*)sourceData;
{
    
    RSAEncryptor *rsa = [RSAEncryptor sharedInstance];
    [rsa loadPublicKeyFromFile:[[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"]];
    
    NSString *result = [rsa rsaEncryptString:sourceData];
    
    return result;
}

-(NSString*)TriDESEncryptWithData:(NSString*)sourceData pulickey:(NSString*)key
{
    NSMutableString *result = [NSMutableString string];
    
    
    
    return result;
}


//- (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height
//{
//    CIImage *barcodeImage;
//    
//    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
//    
//    
//    
//    [filter setValue:data forKey:@"inputMessage"];
//    
//    barcodeImage = [filter outputImage];
//    
//    
//    
//    // 消除模糊
//    
//    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
//    
//    CGFloat scaleY = height / barcodeImage.extent.size.height;
//    
//    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
//    
//    
//    
//    return [UIImage imageWithCIImage:transformedImage];
//    
//}
//
//
//
//- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height
//{
//    CIImage *qrcodeImage;
//    
//    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    
//    
//    
//    [filter setValue:data forKey:@"inputMessage"];
//    
//    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
//    
//    qrcodeImage = [filter outputImage];
//    
//    
//    
//    // 消除模糊
//    
//    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
//    
//    CGFloat scaleY = height / qrcodeImage.extent.size.height;
//    
//    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
//    
//    
//    
//    return [UIImage imageWithCIImage:transformedImage];
//    
//}


+ (UIImage *)resizeImageWithoutInterpolation:(UIImage *)sourceImage size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationNone);
    [sourceImage drawInRect:(CGRect){.size = size}];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)imageWithCIImage:(CIImage *)aCIImage orientation: (UIImageOrientation)anOrientation
{
    if (!aCIImage) return nil;
    
    CGImageRef imageRef = [[CIContext contextWithOptions:nil] createCGImage:aCIImage fromRect:aCIImage.extent];
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:anOrientation];
    CFRelease(imageRef);
    
    return image;
}
//二维码生成
+ (UIImage *)qrImageWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor
{
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (!qrFilter)
    {
        NSLog(@"Error: Could not load filter");
        return nil;
    }
    
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    CIFilter * colorQRFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorQRFilter setValue:qrFilter.outputImage forKey:@"inputImage"];
    //二维码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    if (backGroundColor == nil) {
        backGroundColor = [UIColor whiteColor];
    }
    [colorQRFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    //背景颜色
    [colorQRFilter setValue:[CIColor colorWithCGColor:backGroundColor.CGColor] forKey:@"inputColor1"];
    
    
    CIImage *outputImage = [colorQRFilter valueForKey:@"outputImage"];
    
    UIImage *smallImage = [self imageWithCIImage:outputImage orientation: UIImageOrientationUp];
    
    return [self resizeImageWithoutInterpolation:smallImage size:size];
}
//条形码生成
+ (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor{
    // 生成条形码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    //设置条形码颜色和背景颜色
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setValue:filter.outputImage forKey:@"inputImage"];
    //条形码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    if (backGroundColor == nil) {
        backGroundColor = [UIColor whiteColor];
    }
    [colorFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    //背景颜色
    [colorFilter setValue:[CIColor colorWithCGColor:backGroundColor.CGColor] forKey:@"inputColor1"];
    
    barcodeImage = [colorFilter outputImage];
    
    // 消除模糊
    CGFloat scaleX = size.width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = size.height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}



-(void)processCerFile
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"11" ofType:@"rtf"];
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:file];
    NSString *str = [[NSString alloc]initWithData:[GTMBase64 decodeData:publicKeyFileContent] encoding:NSUTF8StringEncoding];
//    certificate = SecCertificateCreateWithData(nil, (CFDataRef)[GTMBase64 decodeData:publicKeyFileContent]);
    
    NSLog(@"证书 = %@",str);
}


//-(NSString *)tGetX509Info:(X509 *)cerfilepath withoption:(NSInteger)Number
//
//{
//    
//    NSMutableString *certInfo = [[NSMutableString alloc]init];
//    
//    NSMutableString *certCN = [[NSMutableString alloc]init];
//    
//    NSMutableString *_serialNumber = [[NSMutableString alloc]init];
//    
//   NSMutableString * _allCertsList = [[NSMutableString alloc]init];
//    
//    
//    
//    X509 *x509Cert = cerfilepath; //X509证书结构体
//    
//    unsigned char *pTmp = NULL;
//    
//    X509_NAME *issuer = NULL; //X509_NAME结构体，保存证书颁发者信息
//    
//    X509_NAME *subject = NULL; //X509_NAME结构体，保存证书拥有者信息
//    
//    int i;
//    
//    int entriesNum;
//    
//    X509_NAME_ENTRY *name_entry;
//    
//    ASN1_INTEGER *Serial = NULL; //保存证书序列号
//    
//    long Nid;
//    
//    ASN1_TIME *time; //保存证书有效期时间
//    
//    EVP_PKEY *pubKey; //保存证书公钥
//    
//    long Version; //保存证书版本
//    
//    unsigned char derpubkey[1024];
//    
//    //int derpubkeyLen;
//    
//    unsigned char msginfo[1024];
//    
//    int msginfoLen;
//    
//    
//    //打印整个X509结构信息
//    
//    //int ret;
//    
//    BIO *b;
//    
//    b= BIO_new ( BIO_s_file ());
//    
//    BIO_set_fp (b, stdout , BIO_NOCLOSE );
//    
//    // 把 X509 结构打印输出到文件 BIO
//    
//    //X509_print (b,x509Cert);
//    
//    // 释放流
//    
//    BIO_free (b);
//    
//    
//    
//    Version = X509_get_version(x509Cert);                                              //获取证书版本
//    
//    //printf("X509 Version:%ld\n",Version);
//    
//    
//    
//    //获取证书颁发者信息，X509_NAME结构体保存了多项信息，包括国家、组织、部门、通用名、mail等。
//    
//    issuer = X509_get_issuer_name(x509Cert);
//    
//    
//    
//    entriesNum = sk_X509_NAME_ENTRY_num(issuer->entries);            //获取X509_NAME条目个数
//    
//    //循环读取各条目信息
//    
//    for(i=0;i<entriesNum;i++)
//        
//    {
//        
//        //获取第I个条目值
//        
//        name_entry = sk_X509_NAME_ENTRY_value(issuer->entries,i);
//        
//        //获取对象ID
//        
//        Nid = OBJ_obj2nid(name_entry->object);
//        
//        msginfoLen=name_entry->value->length;
//        
//        memcpy(msginfo,name_entry->value->data,msginfoLen);
//        
//        msginfo[msginfoLen]='\0';
//        
//        //根据NID打印出信息
//        
//        //  NSLog(@"issuer type is %d",name_entry->value->type);
//        
//        switch(Nid)
//        
//        {
//                
//            case NID_countryName://国家C
//                
//                //printf("issuer 's C:%s\n",msginfo);
//                
//                [certInfo appendString:[NSString stringWithFormat:@"C=%s,",msginfo]];
//                
//                [certCN appendString:[NSString stringWithFormat:@"C=%s",msginfo]];
//                
//                break;
//                
//            case NID_stateOrProvinceName://省ST
//                
//                //printf("issuer 's ST:%s\n",msginfo);
//                
//                [certInfo appendString:[NSString stringWithFormat:@"ST=%s,",msginfo]];
//                
//                break;
//                
//            case NID_localityName://地区L
//                
//                //printf("issuer 's L:%s\n",msginfo);
//                
//                [certInfo appendString:[NSString stringWithFormat:@"L=%s,",msginfo]];
//                
//                break;
//                
//            case NID_organizationName://组织O
//                
//                //printf("issuer 's O:%s\n",msginfo);
//                
//                [certInfo appendString:[NSString stringWithFormat:@"O=%s,",msginfo]];
//                
//                break;
//                
//            case NID_organizationalUnitName://单位OU
//                
//                //printf("issuer 's OU:%s\n",msginfo);
//                
//                [certInfo appendString:[NSString stringWithFormat:@"OU=%s,",msginfo]];
//                
//                break;
//                
//            case NID_commonName://通用名CN
//                
//                //printf("issuer 's CN:%s\n",msginfo);
//                
//                [certInfo appendString:[NSString stringWithFormat:@"CN=%s",msginfo]];
//                
//                break;
//                
//            case NID_pkcs9_emailAddress://Mail
//                
//                //printf("issuer 's emailAddress:%s\n",msginfo);
//                
//                break;
//                
//        }
//        
//    }
//    
//    [_allCertsList appendString:certInfo];
//    
//    [_allCertsList appendString:@"|"];
//    
//    
//    
//    Serial = X509_get_serialNumber(x509Cert);                    //获取证书序列号
//    
//    //打印证书序列号
//    
//    //printf("serialNumber is: \n");
//    
//    for(i = 0; i < Serial->length; i++)
//        
//    {
//        
//        //printf("%02x", Serial->data[i]);
//        
//        [_serialNumber appendString:[NSString stringWithFormat:@"%02x",Serial->data[i]]];
//        
//    }
//    
//    
//    
//    [_allCertsList appendString:_serialNumber];
//    
//    
//    
//    
//    
//    subject = X509_get_subject_name(x509Cert);            //获取证书主题信息
//    
//    NSMutableString *subjectstring = [[NSMutableString alloc]init];
//    
//    
//    
//    int countsubject = X509_NAME_entry_count(subject);
//    
//    X509_NAME_ENTRY  *subjectEntry = X509_NAME_get_entry(subject,2);
//    
//    X509_NAME_ENTRY_get_object(subjectEntry);
//    
//    X509_NAME_ENTRY_get_data(subjectEntry);
//    
//    NSString  *subjectstr = [NSString stringWithUTF8String:X509_NAME_ENTRY_get_data(subjectEntry)->data];
//    
//    NSLog(@"final test %@",subjectstr);
//    
//    
//    
//    entriesNum = sk_X509_NAME_ENTRY_num(subject->entries);
//    
//    //循环读取个条目信息
//    
//    for(i=0;i<entriesNum;i++)
//        
//    {
//        
//        //获取第I个条目值
//        
//        name_entry = sk_X509_NAME_ENTRY_value(subject->entries,i);
//        
//        Nid = OBJ_obj2nid(name_entry->object);
//        
//        //判断条目编码的类型
//        
//        NSLog(@" type is  %d",name_entry->value->type);
//        
//        
//        
//        if(name_entry->value->type==V_ASN1_BMPSTRING)//把UTF8编码数据转化成可见字符
//            
//        {
//            
//            //ASN1_STRING_to_UTF8(mesre,name_entry->value);
//            
//            msginfoLen=name_entry->value->length;
//            
//            memcpy(msginfo,name_entry->value->data,msginfoLen);
//            
//            msginfo[msginfoLen]='\0';
//            
//            NSString *temptring = [NSString stringWithFormat:@"C=%s,",msginfo];
//            
//            //tempstr = [self EncodeUTF8Str:temptring];
//            
//            //            msginfoLen =UTF8_getc(name_entry->value->data, 2*name_entry->value->length, &rv);
//            
//            //            //msginfoLen =UTF8_putc(name_entry->value->data, name_entry->value->length, rv);
//            
//            //            //memcpy(msginfo,name_entry->value->data,msginfoLen);
//            
//            //            msginfo[msginfoLen]='\0';
//            
//            //            NSData *tempdata = [temptring dataUsingEncoding:NSUTF8StringEncoding];
//            
//            //            NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//            
//            //            NSString*pageSource = [[NSString alloc] initWithData:tempdata encoding:gbkEncoding];
//            
//            NSString*pageSource = [self encodeToPercentEscapeString:temptring];
//            
//            NSString *dataGBK = [pageSource stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            
//            tempstr = dataGBK;
//            
//            
//            
//        }
//        
//        else
//            
//        {
//            
//            tempstr = [NSString stringWithFormat:@"C=%s,",msginfo];
//            
//            msginfoLen=name_entry->value->length;
//            
//            memcpy(msginfo,name_entry->value->data,msginfoLen);
//            
//            msginfo[msginfoLen]='\0';
//            
//        }
//        
//        switch(Nid)
//        
//        {
//                
//            case NID_countryName://国家C
//                
//                //printf("issuer 's C:%s\n",msginfo);
//                
//                [subjectstring appendString:[NSString stringWithFormat:@"C=%s,",msginfo]];
//                
//                break;
//                
//            case NID_stateOrProvinceName://省ST
//                
//                //printf("issuer 's ST:%s\n",msginfo);
//                
//                //[subjectstring appendString:[NSString stringWithFormat:@"ST=%s,",msginfo]];
//                
//                [subjectstring appendString:tempstr];
//                
//                break;
//                
//            case NID_localityName://地区L
//                
//                //printf("issuer 's L:%s\n",msginfo);
//                
//                [subjectstring appendString:[NSString stringWithFormat:@"L=%s,",msginfo]];
//                
//                break;
//                
//            case NID_organizationName://组织O
//                
//                //printf("issuer 's O:%s\n",msginfo);
//                
//                [subjectstring appendString:[NSString stringWithFormat:@"O=%s,",msginfo]];
//                
//                break;
//                
//            case NID_organizationalUnitName://单位OU
//                
//                //printf("issuer 's OU:%s\n",msginfo);
//                
//                [subjectstring appendString:[NSString stringWithFormat:@"OU=%s,",msginfo]];
//                
//                break;
//                
//            case NID_commonName://通用名CNx
//                
//                //printf("issuer 's CN:%s\n",msginfo);
//                
//                [subjectstring appendString:[NSString stringWithFormat:@"CN=%s",msginfo]];
//                
//                break;
//                
//            case NID_pkcs9_emailAddress://Mail
//                
//                //printf("issuer 's emailAddress:%s\n",msginfo);
//                
//                break;
//                
//        }//end switch
//        
//    }
//    
//    
//    
//    time = X509_get_notBefore(x509Cert);                      //获取证书生效日期
//    
//    //printf("Cert notBefore:%s\n",time->data);
//    
//    NSString *notBefore = [NSString stringWithFormat:@"%s",time->data];
//    
//    time = X509_get_notAfter(x509Cert);                        //获取证书过期日期
//    
//    //printf("Cert notAfter:%s\n",time->data);
//    
//    NSString *notAfter = [NSString stringWithFormat:@"%s",time->data];
//    
//    
//    pubKey = X509_get_pubkey(x509Cert);                    //获取证书公钥
//    
//    pTmp=derpubkey;
//    
//    
//    X509_free(x509Cert);
//    
//    NSMutableString *finaldetail = [[NSMutableString alloc]init];
//    
//    NSString *detaiInfo =  [[NSString  alloc]init];
//    
//    NSString *cerEntity = [[NSString alloc]initWithContentsOfFile:RSAX509File encoding:NSUTF8StringEncoding error:nil];
//    
//    
//    
//    NSMutableString *notAftertime = [[NSMutableString alloc]initWithString:@"20"];
//    
//    NSRange range = NSMakeRange (19, 1);
//    
//    
//    
//    switch (Number) {
//            
//        case 1:
//            
//            //[finaldetail appendString:@"Version is "];
//            
//            detaiInfo =  [NSString stringWithFormat:@"%ld",Version];
//            
//            [finaldetail appendString:detaiInfo];
//            
//            break;
//            
//        case 2:
//            
//            detaiInfo =  _serialNumber;
//            
//            [finaldetail appendString:detaiInfo];
//            
//            break;
//            
//        case 3:
//            
//            //[finaldetail appendString:@"Issuer is "];
//            
//            detaiInfo =  certInfo;
//            
//            [finaldetail appendString:detaiInfo];
//            
//            break;
//            
//        case 4:
//            
//            //[finaldetail appendString:@"NotBefore "];
//            
//            [notAftertime appendString:notBefore];
//            
//            [notAftertime insertString:@"-" atIndex:4];
//            
//            [notAftertime insertString:@"-" atIndex:7];
//            
//            [notAftertime insertString:@" " atIndex:10];
//            
//            [notAftertime insertString:@":" atIndex:13];
//            
//            [notAftertime insertString:@":" atIndex:16];
//            
//            [notAftertime replaceCharactersInRange:range withString:@""];
//            
//            [finaldetail appendString:notAftertime];
//            
//            break;
//            
//        case 5:
//            
//            //[finaldetail appendString:@"NotAfter "];
//            
//            [notAftertime appendString:notAfter];
//            
//            [notAftertime insertString:@"-" atIndex:4];
//            
//            [notAftertime insertString:@"-" atIndex:7];
//            
//            [notAftertime insertString:@" " atIndex:10];
//            
//            [notAftertime insertString:@":" atIndex:13];
//            
//            [notAftertime insertString:@":" atIndex:16];
//            
//            [notAftertime replaceCharactersInRange:range withString:@""];
//            
//            [finaldetail appendString:notAftertime];
//            
//            break;
//            
//        case 6:
//            
//            //[finaldetail appendString:@"Cer Entity is \n"];
//            
//            [finaldetail appendString:cerEntity];
//            
//            break;
//            
//        case 7:
//            
//            [finaldetail appendString:certCN];
//            
//            break;
//            
//        case 8:
//            
//            [finaldetail appendString:subjectstring];
//            
//            break;
//            
//        default:
//            
//            break;
//            
//    }
//    
//    return finaldetail;
//    
//}
@end
