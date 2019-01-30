//
//  WorkSheetTableViewCell.h
//  HRMSystem
//
//  Created by Apple on 26/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkSheetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBGView;
@property (weak, nonatomic) IBOutlet UITextView *taskTitle;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
- (IBAction)statusBtnAction:(id)sender;
@property(nonatomic) void (^chageStatus)();
@property (weak, nonatomic) IBOutlet UILabel *ticketNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *assignedDate;
@end

NS_ASSUME_NONNULL_END
