//
//  HolidaysListViewController.m
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "HolidaysListViewController.h"
#import "HolidaysListTableViewCell.h"
@interface HolidaysListViewController ()
{
    NSMutableArray *holidaysList;
}
@end

@implementation HolidaysListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    // Do any additional setup after loading the view.
    holidaysList=[[NSMutableArray alloc] init];
    [self addbackground:self.backgroundView];
    [self makePostCallForPage:HOLIDAYSLIST withParams:nil withRequestCode:10];
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
    
    HolidaysListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HolidaysListTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.cellBackGroundView.layer.cornerRadius=10;
    cell.cellBackGroundView.clipsToBounds=YES;
    NSDictionary *dict=[holidaysList objectAtIndex:indexPath.row];
    cell.DateLbl.text=[dict valueForKey:@"start_date"];
    cell.Reason.text=[dict valueForKey:@"title"];
    cell.DateLbl.textAlignment=NSTextAlignmentCenter;
    cell.Reason.textAlignment=NSTextAlignmentCenter;
    
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
        cell.DateLbl.textColor=[UIColor lightGrayColor];
        cell.Reason.textColor=[UIColor lightGrayColor];
    }else{
        cell.DateLbl.textColor=[UIColor blackColor];
        cell.Reason.textColor=[UIColor blackColor];
    }
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}
@end
