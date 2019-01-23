//
//  ApplyLeaveViewController.h
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextView.h>
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "FTPopOverMenu.h"

NS_ASSUME_NONNULL_BEGIN
@interface ApplyLeaveViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *startDateTxtField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *CommentTxtView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
- (IBAction)startTimeBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *endtimeBtn;
- (IBAction)endTimeBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLeavesLbl;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *typeOfLeave;
@property (weak, nonatomic) IBOutlet UIButton *typeOfLeaveBtn;
- (IBAction)typeOfLeaveBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *toDateLbl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *leaveTypeSegment;
- (IBAction)leaveTypeSegmentAction:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *leavesCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reasonTopValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *halfdaySegment;
- (IBAction)halfDaySegmentAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startDateTop;

@end

NS_ASSUME_NONNULL_END
