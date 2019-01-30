//
//  WorkSheetViewController.m
//  HRMSystem
//
//  Created by Apple on 26/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "WorkSheetViewController.h"
#import "WorkSheetTableViewCell.h"
#import "SRAlertView/SRAlertView.h"
#import "SelectAreaViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "FTPopOverMenu/FTPopOverMenu.h"
@interface WorkSheetViewController ()<PopViewControllerDelegate>
{
    NSMutableArray *tasksList;
    NSString *chageStr;
}
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (weak, nonatomic) IBOutlet UIButton *addnewTaskBtn;
- (IBAction)addnewtaskBtnAction:(id)sender;

@end

@implementation WorkSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addbackground:self.bgView];
    _addnewTaskBtn.layer.cornerRadius=10;
    _addnewTaskBtn.clipsToBounds=YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    [self makePostCallForPage:TASKLIST withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);

    if(reqeustCode==10){
        tasksList=result;
        _taskTableView.reloadData;
    }else if(reqeustCode==100){
        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            [self makePostCallForPage:TASKLIST withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
        }
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tasksList.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkSheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkSheetTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.statusBtn.layer.cornerRadius=10;
    cell.statusBtn.clipsToBounds=YES;
    cell.cellBGView.layer.cornerRadius=10;
    cell.cellBGView.clipsToBounds=YES;
    cell.taskTitle.layer.cornerRadius=10;
    cell.taskTitle.clipsToBounds=YES;
    NSDictionary *dict=[tasksList objectAtIndex:indexPath.row];
    cell.ticketNumberLbl.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"id"]];
    cell.projectNameLbl.text=[NSString stringWithFormat:@": %@",[[dict valueForKey:@"project"] valueForKey:@"title"]];
    cell.mainTitle.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"title"]];
    cell.assignedDate.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"date"]];

    cell.taskTitle.text = [NSString stringWithFormat:@"Description: %@",[dict valueForKey:@"description"]];
//    if([[dict valueForKey:@"status"]  isEqual: @"0"]){
//        [cell.statusBtn setTitle:@"Pending" forState:UIControlStateNormal];
//    }else if([[dict valueForKey:@"status"]  isEqual: @"1"]){
//        [cell.statusBtn setTitle:@"Working" forState:UIControlStateNormal];
//    }else if([[dict valueForKey:@"status"]  isEqual: @"2"]){
//        [cell.statusBtn setTitle:@"Completed" forState:UIControlStateNormal];
//
//    }
    [cell.statusBtn setTitle:[NSString stringWithFormat:@"%@",[dict valueForKey:@"status"]] forState:UIControlStateNormal];

  
    cell.chageStatus = ^{
        chageStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
        [self changeStatus:cell.statusBtn];
        
    };
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}
- (IBAction)addnewtaskBtnAction:(id)sender {
    SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
    vc.delegate=self;
    //    [self.navigationController pushViewController:vc animated:YES];
    //vc.datesShouldBeSelected=[[NSUserDefaults standardUserDefaults] objectForKey:@"SELECTEDDATES"];
    vc.completionBlock = ^(NSMutableDictionary *taskList) {
        
        [self makePostCallForPage:ADDTASK withParams:taskList withRequestCode:100];
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
    
}
- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}
-(void)changeStatus:(id)sender{
    NSMutableArray *statusList=[NSMutableArray arrayWithObjects:@"Pending",@"Working",@"Completed", nil];
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 40;
    configuration.menuWidth = 120;
    configuration.textColor = [UIColor blackColor];
    configuration.textFont = [UIFont boldSystemFontOfSize:14];
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor lightGrayColor];
    configuration.borderWidth = 0.5;
    configuration.textAlignment = UITextAlignmentCenter;
    NSMutableArray *Item=[[NSMutableArray alloc] init];
    
    for(NSString *ste in statusList){
        [Item addObject:ste];
    }
    
    [FTPopOverMenu showForSender:sender
                   withMenuArray:Item
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
//                           self->selectedProject = [self->projectList objectAtIndex:selectedIndex];
//                           self->_projectNameTxtField.text=[self->selectedProject valueForKey:@"title"];
                           [self makePostCallForPage:TASKAPPROVE withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"task_id":self->chageStr,@"status":[NSString stringWithFormat:@"%ld",(long)selectedIndex]} withRequestCode:100];

                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                           //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                           //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
    
}
@end
