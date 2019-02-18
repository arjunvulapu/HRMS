//
//  NotificationDetailVC.h
//  HRMSystem
//
//  Created by Apple on 04/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface NotificationDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *ntitle;
@property (weak, nonatomic) IBOutlet UIImageView *nImage;
@property (weak, nonatomic) IBOutlet UITextView *nDesc;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END
