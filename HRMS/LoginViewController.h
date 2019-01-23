//
//  LoginViewController.h
//  HRMS
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
- (IBAction)submitBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
