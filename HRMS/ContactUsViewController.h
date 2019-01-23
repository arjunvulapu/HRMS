//
//  ContactUsViewController.h
//  Saravana
//
//  Created by apple on 28/09/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactUsViewController : BaseViewController
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *mobileNumberTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailAddressTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *remarksTxtView;
- (IBAction)submitBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *backGroundview;

@end

NS_ASSUME_NONNULL_END
