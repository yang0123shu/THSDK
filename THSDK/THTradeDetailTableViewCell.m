//
//  THTradeDetailTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THTradeDetailTableViewCell.h"

@implementation THTradeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)refreshCellWithTitle:(NSString*)title date:(NSString*)date tradeResult:(NSString*)result
{
    
    _tradeTitleLabel.text = title;
    _tradeDateLabel.text = date;
    _tradeResultLabel.text = result;
}
@end
