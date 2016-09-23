//
//  THTradeDetailTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/2.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THTradeDetailTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *tradeTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *tradeDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *tradeResultLabel;

-(void)refreshCellWithTitle:(NSString*)title date:(NSString*)date tradeResult:(NSString*)result;

@end
