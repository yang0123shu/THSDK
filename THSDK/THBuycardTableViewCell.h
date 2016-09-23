//
//  THBuycardTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/7.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol THBuycardTableViewCellDelegate <NSObject>

-(void)didSelectedTableViewCellAtIndexPath:(NSIndexPath*)indexPath contentDic:(NSDictionary*)dic;

@end


@interface THBuycardTableViewCell : UITableViewCell
{
    NSIndexPath *currentIndexPath;//记录位置
    NSDictionary *contentDic;//记录填充cell的数据
}

@property (nonatomic,weak) id<THBuycardTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UIView *selectedView;


-(void)refreshCellWithIndexPath:(NSIndexPath*)indexPath data:(NSDictionary*)dic;


@end
