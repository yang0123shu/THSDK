//
//  THPaySettingNomalTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THPaySettingNomalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *normalTitleLabel;


@property (weak, nonatomic) IBOutlet UILabel *subscriptLabel;



-(void)refreshCellWithTitle:(NSString*)title subscriptTitle:(NSString*)subTitle;

@end
