//
//  SelectAreaViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
@interface SelectAreaViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic) NSString *restId;
@property (nonatomic) NSString *from;
@property (nonatomic, copy) void (^completionBlock)(NSMutableDictionary *taskList);
@property(nonatomic,strong)NSMutableArray *areasList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBtn;
- (IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *projectNameTxtField;
@property (weak, nonatomic) IBOutlet UIButton *projectBtn;
- (IBAction)projectAction:(id)sender;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *taskTitle;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *descriptionTxtView;
@property (weak, nonatomic) IBOutlet UIButton *addtaskBtn;
- (IBAction)addtaskBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *assignedToTxtFiled;
@property (weak, nonatomic) IBOutlet UIButton *assignedBtn;
- (IBAction)assignedToBtnAction:(id)sender;
@end
