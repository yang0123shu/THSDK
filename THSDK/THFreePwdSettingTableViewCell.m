//
//  THFreePwdSettingTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/5.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THFreePwdSettingTableViewCell.h"

@implementation THFreePwdSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCellWithMoneyCount:(NSInteger)count isSelected:(BOOL)selected
{
    self.countentLable.text = [NSString stringWithFormat:@"%ld元/笔",(long)count];
    if (selected) {
        self.cellSelectedImageView.hidden = NO;
        self.cellSelectedImageView.image  = [UIImage imageNamed:@"u129"];
    }
    else{
        self.cellSelectedImageView.hidden = YES;
    }
}



@end
