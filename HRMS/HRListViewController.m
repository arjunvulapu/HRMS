//
//  HRListViewController.m
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "HRListViewController.h"
#import "AppliedLeavesTableViewCell.h"
#import "SRAlertView/SRAlertView.h"
@interface HRListViewController ()
{
    NSMutableArray *holidaysList;
    NSString *cancelStr;
    NSString *hrSelctedType;

}
@end

@implementation HRListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    // Do any additional setup after loading the view.
    holidaysList=[[NSMutableArray alloc] init];
    [self addbackground:self.backgroundView];
    
    
    [self makePostCallForPage:HRLEAVES withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
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
            [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
 
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
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.acceptBtn.bounds byRoundingCorners:( UIRectCornerBottomLeft) cornerRadii:CGSizeMake(10.0, 10.0)];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.acceptBtn.bounds;
//    maskLayer.path  = maskPath.CGPath;
//    cell.acceptBtn.layer.mask = maskLayer;
//
//    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:cell.hrcancelBtn.bounds byRoundingCorners:( UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 0.0)];
//
//    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
//    maskLayer2.frame = cell.hrcancelBtn.bounds;
//    maskLayer2.path  = maskPath2.CGPath;
//    cell.hrcancelBtn.layer.mask = maskLayer2;
    
    cell.hrcancelBtn.layer.cornerRadius=10;
    cell.hrcancelBtn.clipsToBounds=YES;
    cell.descrptiontxView.layer.cornerRadius=10;
    cell.descrptiontxView.clipsToBounds=YES;
    cell.acceptBtn.layer.cornerRadius=10;
    cell.acceptBtn.clipsToBounds=YES;
    cell.backGroundView.layer.cornerRadius=10;
    cell.backGroundView.clipsToBounds=YES;
    NSDictionary *dict=[holidaysList objectAtIndex:indexPath.row];
    NSDictionary *userDic=[dict valueForKey:@"employee"];
    cell.employeecodeLbl.text=[NSString stringWithFormat:@": %@",[userDic valueForKey:@"id"]];
    cell.employeeNameLbl.text=[NSString stringWithFormat:@": %@ %@",[userDic valueForKey:@"fname"],[userDic valueForKey:@"lname"]];

    cell.leaveFromToLbl.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"date"]];
    cell.leaveStatus.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"cur_status"]];
    cell.appliedOnLbl.text=[NSString stringWithFormat:@": %@",[dict valueForKey:@"date"]];

    if([[dict valueForKey:@"cur_status"] isEqualToString:@"Declined"]){
        [cell.hrcancelBtn setHidden:YES];
    }else{
        [cell.hrcancelBtn setHidden:NO];

    }
    if([[dict valueForKey:@"cur_status"] isEqualToString:@"Approved"]){
        [cell.acceptBtn setHidden:YES];
    }else{
        [cell.acceptBtn setHidden:NO];
        
    }
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
    NSDate *newDate = [formatter dateFromString:[dict valueForKey:@"start_date"]];
    
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
    }else{
        cell.leaveFromToLbl.textColor=[UIColor blackColor];
        cell.leaveStatus.textColor=[UIColor blackColor];
        cell.leaveType.textColor=[UIColor blackColor];
        cell.leaveTypeRLbl.textColor=[UIColor blackColor];
        cell.descrptiontxView.textColor=[UIColor blackColor];
    }
    cell.cancelBtn.hidden=YES;
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
    cell.acceptBtnAction = ^{
        self->cancelStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
        self->hrSelctedType=@"accept";

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
        self->hrSelctedType=@"cancel";
        self->cancelStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];

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
        if([hrSelctedType isEqual:@"cancel"]){
            [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":cancelStr,@"status":@"2"} withRequestCode:11];
        }else{
            [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":cancelStr,@"status":@"1"} withRequestCode:11];

        }
    }
}
- (IBAction)statusSegmentAction:(id)sender {
    if(_statusSegment.selectedSegmentIndex==0){
        [self makePostCallForPage:HRLEAVES withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"status":@"0"} withRequestCode:10];

    }else if(_statusSegment.selectedSegmentIndex==1){
        [self makePostCallForPage:HRLEAVES withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"status":@"1"} withRequestCode:10];

    }else if(_statusSegment.selectedSegmentIndex==2){
        [self makePostCallForPage:HRLEAVES withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"status":@"2"} withRequestCode:10];

    }else if(_statusSegment.selectedSegmentIndex==3){
        [self makePostCallForPage:HRLEAVES withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"status":@"3"} withRequestCode:10];
        
    }
}
@end
