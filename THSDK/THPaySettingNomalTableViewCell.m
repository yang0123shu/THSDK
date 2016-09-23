//
//  THPaySettingNomalTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THPaySettingNomalTableViewCell.h"

@implementation THPaySettingNomalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)refreshCellWithTitle:(NSString*)title subscriptTitle:(NSString*)subTitle
{
    _normalTitleLabel.text = title;
    if ([subTitle isEqualToString:@""] || subTitle == nil) {
        self.subscriptLabel.hidden = YES;
    }
    else{
        self.subscriptLabel.text = subTitle;
    }
}
@end
