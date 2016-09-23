//
//  THAssetsTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THAssetsTableViewCell.h"

@implementation THAssetsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)refreshCellWithTitle:(NSString*)title detail:(NSString*)detail
{
    _titleLable.text = title;
    _detailLabel.text = detail;
}


@end
