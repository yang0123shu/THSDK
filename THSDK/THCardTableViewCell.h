//
//  THCardTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/12.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THCardTableViewCellDelegate <NSObject>

-(void)cellDecreasedOrIncreased:(BOOL)increase indexPath:(NSIndexPath*)index money:(NSString*)money;

@end


@interface THCardTableViewCell : UITableViewCell
{
    NSIndexPath *index;
    NSInteger cellBagde;
    NSDictionary *data;
}

@property (nonatomic,weak)id <THCardTableViewCellDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIImageView *decreaseImage;

@property (weak, nonatomic) IBOutlet UIImageView *increaseImage;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *bagdeLabel;


-(void)refreshCellWithMoney:(NSString*)money bagde:(NSInteger)bagde indexPath:(NSIndexPath*)indexPath;

@end
