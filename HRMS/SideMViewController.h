//
//  MenuViewController.h
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SWUITableViewCell : UITableViewCell
@property (nonatomic) IBOutlet UILabel *label;
@end

@interface SideMViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UIButton *topbutton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewLeading;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UIView *LOGINVIEW;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
- (IBAction)signupBtnAction:(id)sender;
- (IBAction)loginBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signupTailing;
- (IBAction)toCompany:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;

@end
