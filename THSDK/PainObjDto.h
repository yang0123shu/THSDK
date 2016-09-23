//
//  PainObjDto.h
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PainObj.h"
@interface PainObjDto : NSObject

@property (nonatomic)PainObj *painobj;

@property (nonatomic)NSString *uniqueId;

+(instancetype)shareObjDto;
-(NSString *)toString;

@end
