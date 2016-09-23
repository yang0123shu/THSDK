//
//  THCardOptionTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/12.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THCardOptionTableViewCell.h"

@implementation THCardOptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCellWithImage:(UIImage*)image title:(NSString*)title title1:(NSString*)title1 title2:(NSString*)title2 indexPath:(NSIndexPath*)index
{
    _titleLabel.text = title;
    if (image != nil) {
        _title1Label.hidden = YES;
        _subtitle1Label.hidden = YES;
        _cardImageView.hidden = NO;
        _cardImageView.image = image;
    }else
    {
        _title1Label.hidden = NO;
        _subtitle1Label.hidden = NO;
        _cardImageView.hidden = YES;
        _title1Label.text = title1;
        _subtitle1Label.text = title2;
    }
}


@end
