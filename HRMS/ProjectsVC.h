//
//  ProjectsVC.h
//  HRMSystem
//
//  Created by Apple on 05/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *projectsTable;
@property (weak, nonatomic) IBOutlet UIButton *todoBtn;
@property (weak, nonatomic) IBOutlet UIButton *doingBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
- (IBAction)todoBtnAction:(id)sender;
- (IBAction)doingBtnAction:(id)sender;
- (IBAction)doneBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIView *v3;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

NS_ASSUME_NONNULL_END
