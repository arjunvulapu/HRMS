//
//  EmployeesTableViewCell.h
//  HRMSystem
//
//  Created by Apple on 28/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmployeesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *employeeId;
@property (weak, nonatomic) IBOutlet UILabel *employeeName;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *designationLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *worksheetBtn;
- (IBAction)workSheetBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property(nonatomic) void (^openWorkSheet)();
@end

NS_ASSUME_NONNULL_END
