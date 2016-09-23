//
//  THPaySettingCheckTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THPaySettinCheckCellDelegate <NSObject>

-(void)switchInCellBeTouched:(BOOL)isOn title:(NSString*)title indexPath:(NSIndexPath*)indexPath;

@end



@interface THPaySettingCheckTableViewCell : UITableViewCell
{
    BOOL switchOn;
}
@property (nonatomic,weak)id <THPaySettinCheckCellDelegate> delegate;


@property (nonatomic)NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

-(void)refreshCellWithTitle:(NSString*)title isOn:(BOOL)on indexPath:(NSIndexPath*)index;



@end
