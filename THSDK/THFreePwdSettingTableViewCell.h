//
//  THFreePwdSettingTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/5.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THFreePwdSettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *countentLable;

@property (weak, nonatomic) IBOutlet UIImageView *cellSelectedImageView;

-(void)refreshCellWithMoneyCount:(NSInteger)count isSelected:(BOOL)selected;

@end
