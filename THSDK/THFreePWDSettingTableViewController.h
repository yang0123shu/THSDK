//
//  THFreePWDSettingTableViewController.h
//  THSDKPro
//
//  Created by 阳书成 on 16/9/5.
//  Copyright © 2016年 阳书成. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol THFreePWDSettingVCDelegate <NSObject>

-(void)popBackSelectedCount:(NSString*)text;

@end

@interface THFreePWDSettingTableViewController : UITableViewController

@property (nonatomic,weak) id <THFreePWDSettingVCDelegate> delegate;

@property (nonatomic)NSMutableArray *dataSource;


@end
