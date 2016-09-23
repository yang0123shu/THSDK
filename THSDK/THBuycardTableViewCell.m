//
//  THBuycardTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/7.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THBuycardTableViewCell.h"

@implementation THBuycardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCellWithIndexPath:(NSIndexPath*)indexPath data:(NSDictionary*)dic
{
    currentIndexPath = indexPath;
    contentDic = dic;
    self.dateLabel.text = dic[@"date"];
    self.accountLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"account"]];
    [self.selectedView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedCell:)]];
}
-(void)selectedCell:(UITapGestureRecognizer*)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedTableViewCellAtIndexPath:contentDic:)]) {
        [_delegate didSelectedTableViewCellAtIndexPath:currentIndexPath contentDic:contentDic];
    }
}

@end
