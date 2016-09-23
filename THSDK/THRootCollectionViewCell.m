//
//  THRootCollectionViewCell.m
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import "THRootCollectionViewCell.h"

@implementation THRootCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshCellWithImage:(UIImage *)image title:(NSString*)title indexPath:(NSIndexPath*)indexPath
{
    _imageView.image = image;
    _titleLabel.text = title;
    index = indexPath;
    [_touchedView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellBeTouched:)]];
}

-(void)cellBeTouched:(UITapGestureRecognizer *)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(rootCollectionViewCellBeTouched:indexPath:)]){
        [_delegate rootCollectionViewCellBeTouched:_titleLabel.text indexPath:index];
    }
}

@end
