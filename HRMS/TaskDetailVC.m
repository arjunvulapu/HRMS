//
//  TaskDetailVC.m
//  HRMSystem
//
//  Created by Apple on 11/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TaskDetailVC.h"
#import "FTPopOverMenu/FTPopOverMenu.h"

@interface TaskDetailVC ()
{
    NSString *chageStr;
    NSString *currStatus;
}
@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addbackground:self.bgview];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    
    self.statusBtn.layer.cornerRadius=10;
    self.statusBtn.clipsToBounds=YES;
    self.statusBtn.hidden=YES;

    self.taskTitle.layer.cornerRadius=10;
    self.taskTitle.clipsToBounds=YES;
    self.ticketNumberLbl.text=[NSString stringWithFormat:@": %@",[_taskDetails valueForKey:@"title"]];
    self.projectNameLbl.text=[NSString stringWithFormat:@": %@",[_taskDetails valueForKey:@"title"]];
    self.mainTitle.text=[NSString stringWithFormat:@": %@",[_taskDetails valueForKey:@"title"]];
    self.assignedDate.text=[NSString stringWithFormat:@": %@",[_taskDetails valueForKey:@"date"]];
    
    self.vcTitle.text=[NSString stringWithFormat:@"%@-(%@)",_ProjectName,[_taskDetails valueForKey:@"id"]];

    self.taskTitle.text = [NSString stringWithFormat:@"Description: %@",[_taskDetails valueForKey:@"description"]];
    //    if([[dict valueForKey:@"status"]  isEqual: @"0"]){
    //        [self.statusBtn setTitle:@"Pending" forState:UIControlStateNormal];
    //    }else if([[dict valueForKey:@"status"]  isEqual: @"1"]){
    //        [self.statusBtn setTitle:@"Working" forState:UIControlStateNormal];
    //    }else if([[dict valueForKey:@"status"]  isEqual: @"2"]){
    //        [self.statusBtn setTitle:@"Completed" forState:UIControlStateNormal];
    //
    //    }
    [self.statusBtn setTitle:[NSString stringWithFormat:@"%@",[_taskDetails valueForKey:@"status"]] forState:UIControlStateNormal];
    
            chageStr=[NSString stringWithFormat:@"%@",[_taskDetails valueForKey:@"id"]];

//    self.chageStatus = ^{
//        chageStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
//        [self changeStatus:self.statusBtn];
//
//    };
}
- (IBAction)statusBtnAction:(id)sender;
{
    [self changeStatus:self.statusBtn];
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
                           currStatus=[statusList objectAtIndex:selectedIndex];

                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                           //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                           //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
    
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if(reqeustCode==10){
//        tasksList=result;
//        _taskTableView.reloadData;
    }else if(reqeustCode==100){
        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
           // [self makePostCallForPage:TASKLIST withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
            [self.statusBtn setTitle:[NSString stringWithFormat:@"%@",currStatus] forState:UIControlStateNormal];

        }
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
