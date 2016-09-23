//
//  THRootCollectionViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THRootCollectionViewCellDelegate <NSObject>

-(void)rootCollectionViewCellBeTouched:(NSString*)itemTitle indexPath:(NSIndexPath*)indexPath;

@end



@interface THRootCollectionViewCell : UICollectionViewCell
{
    NSIndexPath *index;
}

@property (nonatomic,weak) id<THRootCollectionViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *touchedView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



-(void)refreshCellWithImage:(UIImage *)image title:(NSString*)title indexPath:(NSIndexPath*)indexPath;


@end
