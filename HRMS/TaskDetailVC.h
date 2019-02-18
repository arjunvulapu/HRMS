//
//  TaskDetailVC.h
//  HRMSystem
//
//  Created by Apple on 11/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *cellBGView;
@property (weak, nonatomic) IBOutlet UITextView *taskTitle;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
- (IBAction)statusBtnAction:(id)sender;
@property(nonatomic) void (^chageStatus)();
@property (weak, nonatomic) IBOutlet UILabel *ticketNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *assignedDate;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (strong, nonatomic)  NSDictionary *taskDetails;
@property (strong, nonatomic)   NSString *ProjectName;
@property (weak, nonatomic) IBOutlet UILabel *vcTitle;

@end

NS_ASSUME_NONNULL_END
