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

@end

NS_ASSUME_NONNULL_END
