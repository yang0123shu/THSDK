//
//  THAssetsTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/8/30.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THAssetsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


-(void)refreshCellWithTitle:(NSString*)title detail:(NSString*)detail;

@end
