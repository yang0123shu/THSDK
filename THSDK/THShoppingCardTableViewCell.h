//
//  THShoppingCardTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/8/31.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THShoppingCardTableViewCell : UITableViewCell

/**
 *  是否为展示已过期的消费卡cell
 */
@property (nonatomic)BOOL isOutTime;


@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


-(void)refreshCellWiththumbImageUrl:(NSString*)urlString value:(NSString*)value vailideDate:(NSString*)date;


@end
