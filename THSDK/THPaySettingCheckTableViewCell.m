//
//  THPaySettingCheckTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THPaySettingCheckTableViewCell.h"

@implementation THPaySettingCheckTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCellWithTitle:(NSString*)title isOn:(BOOL)on indexPath:(NSIndexPath*)index
{
    switchOn = on;
    self.indexPath = index;
    self.detailTitleLabel.text = title;
    [self.switchControl setOn:on animated:YES];
    [self.switchControl addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
}

-(void)switchTouched:(UISwitch*)sender
{
    switchOn = !switchOn;
    [sender setOn:switchOn animated:YES];
    if(_delegate && [_delegate respondsToSelector:@selector(switchInCellBeTouched:title:indexPath:)])
    {
        [_delegate switchInCellBeTouched:switchOn title:self.detailTitleLabel.text indexPath:self.indexPath];
    }
}


@end
