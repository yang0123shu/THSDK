//
//  THOrderInfoTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/7.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THOrderInfoTableViewCell.h"

@implementation THOrderInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellRefreshWithDataDictionary:(NSDictionary*)paramDic
{
    self.orderNumLabel.text = paramDic[@"orderNum"];
    self.orderTrsNumLabel.text = paramDic[@"orderTrsNum"];
    self.orderCreatedDateLabel.text = paramDic[@"createdDate"];
}

@end
