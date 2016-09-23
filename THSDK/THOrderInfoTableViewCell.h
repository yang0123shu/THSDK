//
//  THOrderInfoTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/7.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THOrderInfoTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderTrsNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderCreatedDateLabel;


-(void)cellRefreshWithDataDictionary:(NSDictionary*)paramDic;

@end
