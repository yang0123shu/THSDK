//
//  THCardOptionTableViewCell.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/12.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THCardOptionTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *title1Label;

@property (weak, nonatomic) IBOutlet UILabel *subtitle1Label;

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;



-(void)refreshCellWithImage:(UIImage*)image title:(NSString*)title title1:(NSString*)title1 title2:(NSString*)title2 indexPath:(NSIndexPath*)index;



@end
