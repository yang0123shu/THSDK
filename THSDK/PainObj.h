//
//  PainObj.h
//  THSDK
//
//  Created by 阳书成 on 16/9/20.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#import "User.h"
@interface PainObj : NSObject

@property (nonatomic)Order *order;

@property (nonatomic)User *user;

@property (nonatomic)NSString *transcode;

+(instancetype)shareObj;

-(NSString*)toString;

@end
