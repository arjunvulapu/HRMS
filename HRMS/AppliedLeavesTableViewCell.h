//
//  AppliedLeavesTableViewCell.h
//  HRMSystem
//
//  Created by Apple on 22/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppliedLeavesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leaveFromToLbl;
@property (weak, nonatomic) IBOutlet UILabel *leaveStatus;
@property (weak, nonatomic) IBOutlet UILabel *leaveType;
@property (weak, nonatomic) IBOutlet UILabel *leaveTypeRLbl;
@property (weak, nonatomic) IBOutlet UITextView *descrptiontxView;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelBtnAction:(id)sender;
@property (nonatomic) void (^Cancel)();
@property (weak, nonatomic) IBOutlet UIStackView *hrView;
@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UIButton *hrcancelBtn;
- (IBAction)acceptBtnAction:(id)sender;
- (IBAction)hrCancelledBtnAction:(id)sender;
@property(nonatomic) void (^acceptBtnAction)();
@property(nonatomic) void (^hrCancelBtnAction)();
@property (weak, nonatomic) IBOutlet UILabel *employeecodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *employeeNameLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottom;
@property (weak, nonatomic) IBOutlet UILabel *appliedOnLbl;

@end

NS_ASSUME_NONNULL_END
