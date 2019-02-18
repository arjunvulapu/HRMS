//
//  NotificationDetailVC.m
//  HRMSystem
//
//  Created by Apple on 04/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "NotificationDetailVC.h"

@interface NotificationDetailVC ()

@end

@implementation NotificationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addbackground:_bgView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    self.titleLbl.text=Localized(@"Notification Details");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
