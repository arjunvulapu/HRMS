//
//  ListViewController.m
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ListViewController.h"
#import "AppliedLeavesTableViewCell.h"
@interface ListViewController ()
{
    NSMutableArray *holidaysList;
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

    cell.backGroundView.layer.cornerRadius=10;
    cell.backGroundView.clipsToBounds=YES;
    NSDictionary *dict=[holidaysList objectAtIndex:indexPath.row];
    cell.leaveFromToLbl.text=[NSString stringWithFormat:@"%@-%@",[dict valueForKey:@"start_date"],[dict valueForKey:@"end_date"]];
    cell.leaveStatus.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"cur_status"]];
    cell.leaveType.text=@"Leave Type";
    cell.leaveTypeRLbl.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"leave_type"]];
    cell.descrptiontxView.text = [NSString stringWithFormat:@"Reason:%@",[dict valueForKey:@"description"]];
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
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}
@end
