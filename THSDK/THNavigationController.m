//
//  THNavigationController.m
//  THSDKPro
//
//  Created by 阳书成 on 16/9/14.
//  Copyright © 2016年 阳书成. All rights reserved.
//


//导航栏


#import "THNavigationController.h"

@interface THNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation THNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    // Do any additional setup after loading the view.
}
- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
//    return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end
