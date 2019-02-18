//
//  DailyWorkSheetViewController.h
//  HRMSystem
//
//  Created by Apple on 28/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SZTextView/Classes/SZTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DailyWorkSheetViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *daySheetTable;
@property (weak, nonatomic) IBOutlet UIButton *sendbtn;
- (IBAction)sendBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet SZTextView *messageTxtView;
@property (weak, nonatomic) NSString *addedBy;
@property (weak, nonatomic) NSString *whosWorksheet;
@property (weak, nonatomic) IBOutlet UILabel *workSheetTitle;
@property (weak, nonatomic) NSString *Fname;
@property (weak, nonatomic) NSString *Lname;
@property (weak, nonatomic) NSString *from;

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
- (IBAction)commentBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *msgViewTop;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;

@end

NS_ASSUME_NONNULL_END
