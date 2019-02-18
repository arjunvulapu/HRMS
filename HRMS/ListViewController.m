//
//  ListViewController.m
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ListViewController.h"
#import "AppliedLeavesTableViewCell.h"
#import "SRAlertView/SRAlertView.h"
@interface ListViewController ()
{
    NSMutableArray *holidaysList;
    NSString *cancelStr;
}
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    // Do any additional setup after loading the view.
    holidaysList=[[NSMutableArray alloc] init];
    [self addbackground:self.backgroundView];
    
    
    [self makePostCallForPage:USERLEAVES withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==10){
        holidaysList=result;
        _holidaysTableView.reloadData;
    }else if(reqeustCode==11){
        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            [self makePostCallForPage:USERLEAVES withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
 
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return holidaysList.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppliedLeavesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppliedLeavesTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cancelBtn.layer.cornerRadius=10;
    cell.cancelBtn.clipsToBounds=YES;
    cell.backGroundView.layer.cornerRadius=10;
    cell.backGroundView.clipsToBounds=YES;
    cell.descrptiontxView.layer.cornerRadius=10;
    cell.descrptiontxView.clipsToBounds=YES;
    NSDictionary *dict=[holidaysList objectAtIndex:indexPath.row];
    cell.leaveFromToLbl.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"date"]];
    cell.leaveStatus.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"cur_status"]];
    
    cell.leaveType.text=@"Leave Type";
    NSString *leaveRStr=[dict valueForKey:@"leave_type"];
    NSString *duRStr=[dict valueForKey:@"duration"];
    NSString *dusRStr=[dict valueForKey:@"duration_shift"];
    if(duRStr.length>0){
        leaveRStr=[NSString  stringWithFormat:@"%@-%@",leaveRStr,duRStr];
        if(dusRStr.length>0){
            leaveRStr=[NSString  stringWithFormat:@"%@,%@",leaveRStr,dusRStr];
        }
    }
    
    cell.leaveTypeRLbl.text=[NSString stringWithFormat:@": %@",leaveRStr];
    cell.descrptiontxView.text = [NSString stringWithFormat:@"Reason: %@",[dict valueForKey:@"description"]];
//    cell.leaveFromToLbl.textAlignment=NSTextAlignmentCenter;
//    cell.leaveStatus.textAlignment=NSTextAlignmentCenter;
//    cell.leaveType.textAlignment=NSTextAlignmentCenter;
//    cell.leaveTypeRLbl.textAlignment=NSTextAlignmentCenter;
//    cell.descrptiontxView.textAlignment=NSTextAlignmentJustified;
    
    NSDateFormatter *formatter = nil;
    formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *today = [NSDate date]; // it will give you current date
    NSDate *newDate = [formatter dateFromString:[dict valueForKey:@"date"]];
    
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [newDate compare:today]; // comparing two dates
    
//    if(result==NSOrderedAscending)
//        NSLog(@"today is less");
//    else if(result==NSOrderedDescending)
//        NSLog(@"newDate is less");
//    else
//        NSLog(@"Both dates are same");
    if(result==NSOrderedAscending){
        cell.leaveFromToLbl.textColor=[UIColor lightGrayColor];
        cell.leaveStatus.textColor=[UIColor lightGrayColor];
        cell.leaveType.textColor=[UIColor lightGrayColor];
        cell.leaveTypeRLbl.textColor=[UIColor lightGrayColor];
        cell.descrptiontxView.textColor=[UIColor lightGrayColor];
        
        [cell.cancelBtn setHidden:YES];
        cell.textViewBottom.constant=8;
    }else{
        if([[dict valueForKey:@"cur_status"] isEqualToString:@"Cancelled"]){
            [cell.cancelBtn setHidden:YES];
            cell.textViewBottom.constant=8;
        }else{
            [cell.cancelBtn setHidden:NO];
            cell.textViewBottom.constant=46;
            
        }
//        [cell.cancelBtn setHidden:NO];
//        cell.textViewBottom.constant=46;
        
        cell.leaveFromToLbl.textColor=[UIColor blackColor];
        cell.leaveStatus.textColor=[UIColor blackColor];
        cell.leaveType.textColor=[UIColor blackColor];
        cell.leaveTypeRLbl.textColor=[UIColor blackColor];
        cell.descrptiontxView.textColor=[UIColor blackColor];
    }
    cell.Cancel = ^{
        self->cancelStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"Please Conform To Cancel"
//                              message:nil
//                              delegate:self
//                              cancelButtonTitle:@"Cancel"
//                              otherButtonTitles:@"Sure", nil];
//        [alert show];
        
        
        SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"HRMSystem"
                                                               icon:nil
                                                            message:@"Please Conform To Cancel"
                                                    leftActionTitle:@"Sure"
                                                   rightActionTitle:@"Cancel"
                                                     animationStyle:SRAlertViewAnimationZoomSpring
                                                           delegate:self];
        [alertView show];
       // [self makePostCallForPage:LEAVECANCEL withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":[dict valueForKey:@"id"]} withRequestCode:11];

    };
    cell.hrView.hidden=YES;

    cell.acceptBtnAction = ^{
        SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"HRMSystem"
                                                               icon:nil
                                                            message:@"Please Conform To Accept"
                                                    leftActionTitle:@"Sure"
                                                   rightActionTitle:@"Cancel"
                                                     animationStyle:SRAlertViewAnimationZoomSpring
                                                           delegate:self];
        [alertView show];
        
    };
    cell.hrCancelBtnAction  = ^{
        SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"HRMSystem"
                                                               icon:nil
                                                            message:@"Please Conform To Reject"
                                                    leftActionTitle:@"Sure"
                                                   rightActionTitle:@"Cancel"
                                                     animationStyle:SRAlertViewAnimationZoomSpring
                                                           delegate:self];
        [alertView show];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger) buttonIndex{
    
    if (buttonIndex == 1) {
        // Do it!
         [self makePostCallForPage:LEAVECANCEL withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":cancelStr} withRequestCode:11];

    } else {
        // Cancel
    }
}
- (void)alertViewDidSelectAction:(SRAlertViewActionType)actionType {
    NSLog(@"%zd", actionType);
    if(actionType==SRAlertViewActionTypeLeft){
        [self makePostCallForPage:LEAVECANCEL withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":cancelStr} withRequestCode:11];

    }
}
@end
