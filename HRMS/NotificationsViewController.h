//
//  NotificationsViewController.h
//  HRMSystem
//
//  Created by Apple on 04/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface NotificationsViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *notificationsTableView;

@end

NS_ASSUME_NONNULL_END
