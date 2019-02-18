//
//  NotificationsViewController.m
//  HRMSystem
//
//  Created by Apple on 04/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "NotificationsViewController.h"
#import "NotificationTableViewCell.h"
#import "NotificationDetailVC.h"
@interface NotificationsViewController ()
{
    NSMutableArray *notificationList;
}
@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbackground:self.bgView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    [self makePostCallForPage:NOTIFICATIONS withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if(reqeustCode==10){
        notificationList=result;
        _notificationsTableView.reloadData;
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
    
    return notificationList.count;
//    return 10;

}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.bgView.layer.cornerRadius=10;
    cell.bgView.clipsToBounds=YES;
    cell.nMsg.layer.cornerRadius=10;
    cell.nMsg.clipsToBounds=YES;
    NSDictionary *dict=[notificationList objectAtIndex:indexPath.row];

    cell.nTitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];
    cell.nMsg.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"description"]];
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NotificationDetailVC *NDVC=[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationDetailVC"];
//    [self.navigationController pushViewController:NDVC animated:YES];
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}
@end
