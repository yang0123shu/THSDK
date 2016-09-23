//
//  THCardTableViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/12.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THCardTableViewCell.h"

@implementation THCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _moneyLabel.layer.masksToBounds = YES;
    _bagdeLabel.layer.masksToBounds = YES;
    _moneyLabel.layer.cornerRadius = kBtnCorner;
    _bagdeLabel.layer.cornerRadius = _bagdeLabel.frame.size.width/2;
    // Initialization code
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    _moneyLabel.layer.masksToBounds = YES;
    _bagdeLabel.layer.masksToBounds = YES;
    _moneyLabel.layer.cornerRadius = kBtnCorner;
    _bagdeLabel.layer.cornerRadius = _bagdeLabel.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)refreshCellWithMoney:(NSString*)money bagde:(NSInteger)bagde indexPath:(NSIndexPath*)indexPath
{
    index = indexPath;
    cellBagde = bagde;
    
    [_decreaseImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDecreaseCard:)]];
    [_increaseImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toIncreaseCard:)]];
    _moneyLabel.text = money;
    _moneyLabel.layer.masksToBounds = YES;
    _bagdeLabel.layer.masksToBounds = YES;
    _moneyLabel.layer.cornerRadius = kBtnCorner;
    _bagdeLabel.layer.cornerRadius = _bagdeLabel.frame.size.width/2;
    if (bagde == 0) {
        _bagdeLabel.hidden = YES;
        return;
    }
    _bagdeLabel.text = [NSString stringWithFormat:@"%ld",bagde];
}

-(void)toDecreaseCard:(UITapGestureRecognizer*)sender
{
    cellBagde = cellBagde - 1;
    _moneyLabel.layer.masksToBounds = YES;
    _bagdeLabel.layer.masksToBounds = YES;
    _moneyLabel.layer.cornerRadius = kBtnCorner;
    _bagdeLabel.layer.cornerRadius = _bagdeLabel.frame.size.width/2;
    if (cellBagde == 0) {
        _bagdeLabel.hidden = YES;
    }
    else{
        _bagdeLabel.hidden = NO;
        _bagdeLabel.text = [NSString stringWithFormat:@"%ld",cellBagde];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(cellDecreasedOrIncreased:indexPath:money:)]) {
        [_delegate cellDecreasedOrIncreased:NO indexPath:index money:_moneyLabel.text];
    }
}

-(void)toIncreaseCard:(UITapGestureRecognizer*)sender
{
    cellBagde = cellBagde + 1;
    _moneyLabel.layer.masksToBounds = YES;
    _bagdeLabel.layer.masksToBounds = YES;
    _moneyLabel.layer.cornerRadius = kBtnCorner;
    _bagdeLabel.layer.cornerRadius = _bagdeLabel.frame.size.width/2;
    _bagdeLabel.hidden = NO;
    _bagdeLabel.text = [NSString stringWithFormat:@"%ld",cellBagde];
    if (_delegate && [_delegate respondsToSelector:@selector(cellDecreasedOrIncreased:indexPath:money:)]) {
        [_delegate cellDecreasedOrIncreased:YES indexPath:index money:_moneyLabel.text];
    }
}

@end
