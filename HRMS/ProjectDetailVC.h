//
//  ProjectDetailVC.h
//  HRMSystem
//
//  Created by Apple on 09/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *vcTitle;
@property (weak, nonatomic) IBOutlet UILabel *ptitle;
@property (weak, nonatomic) IBOutlet UILabel *leadTitle;
@property (weak, nonatomic) IBOutlet UILabel *teamTitle;


@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *projectsTable;
@property (weak, nonatomic) IBOutlet UIButton *todoBtn;
@property (weak, nonatomic) IBOutlet UIButton *doingBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
- (IBAction)todoBtnAction:(id)sender;
- (IBAction)doingBtnAction:(id)sender;
- (IBAction)doneBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bottomView;


// Collection views oulets..

@property (weak, nonatomic) IBOutlet UICollectionView *leadCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *teamCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *teamCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taskTableViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *projectDescTxtView;

@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *clientName;
@property (weak, nonatomic) IBOutlet UILabel *endDate;

@property (weak, nonatomic) NSDictionary *projectDetials;

@end

NS_ASSUME_NONNULL_END
