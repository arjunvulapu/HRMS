//
//  DailyWorkSheetViewController.m
//  HRMSystem
//
//  Created by Apple on 28/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "DailyWorkSheetViewController.h"
#import "DailySheetTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
@interface DailyWorkSheetViewController ()
{
    NSMutableArray *tasksList,*listofSearchEmployee,*addedManually;
    NSTimer *chatTimer;
    BOOL callGoingOn;
}
@end

@implementation DailyWorkSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    // Do any additional setup after loading the view.
    self.messageTxtView.text=@"";
    [self addbackground:_bgView];
    tasksList=[[NSMutableArray alloc] init];
    listofSearchEmployee=[[NSMutableArray alloc] init];
    addedManually=[[NSMutableArray alloc] init];
    _daySheetTable.delegate=self;
    _daySheetTable.dataSource=self;
    self.messageTxtView.layer.cornerRadius=5;
    self.messageTxtView.clipsToBounds=YES;

    self.messageTxtView.placeholder = @"Enter Task";
    self.messageTxtView.placeholderTextColor = [UIColor lightGrayColor];
    [self makePostCallForPage:WORKSHEETLIST withParams:@{@"employee_id":_whosWorksheet} withRequestCode:10];
    _workSheetTitle.text=[NSString stringWithFormat:@"%@-Work Sheet",_Fname];
//    [chatTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    callGoingOn=YES;
    chatTimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];

}
-(void)viewDidDisappear:(BOOL)animated{
    [chatTimer invalidate];
}
- (void) handleTimer:(NSTimer *)timer
{
    NSLog(@"called");
    //Do calculations.
    if(!callGoingOn){
    if(tasksList.count>0){
    NSMutableDictionary *dic =[tasksList lastObject];
    [self makePostWithOutHUDCallForPage:WORKSHEETLIST withParams:@{@"employee_id":_whosWorksheet,@"last_id":[dic valueForKey:@"id"]} withRequestCode:11];
    }else{
        [self makePostWithOutHUDCallForPage:WORKSHEETLIST withParams:@{@"employee_id":_whosWorksheet} withRequestCode:11];
    }
    }

}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if(reqeustCode==10){
        callGoingOn=NO;
        for(NSMutableDictionary *dic in result){
            [tasksList addObject:dic];

        }
       
        
        _daySheetTable.reloadData;
        int yourSection = tasksList.count;
        if(tasksList.count>0){
//        NSMutableDictionary *res=[tasksList objectAtIndex:yourSection-1];
//        NSMutableArray *listCount=[res valueForKey:@"messages"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tasksList.count-1 inSection:0];
        [self.daySheetTable scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
        }
    }
    else if(reqeustCode==100){
        callGoingOn=NO;
        NSLog(@"%@",result);
//        if([result valueForKey:@"status"]){
//        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
//            NSString *str=[result valueForKey:@"message"];
//            [self showErrorAlertWithMessage:Localized(str)];
//        } else {
////            _messageTxtView.text=@"";
////            [self makePostCallForPage:WORKSHEETLIST withParams:@{@"employee_id":_whosWorksheet} withRequestCode:10];
//        }
//        }
        
    }
    else if(reqeustCode==11){
        callGoingOn=NO;

//        for(NSMutableDictionary *dic in tasksList){
//            if([dic valueForKey:@"New"]){
//                if([[dic valueForKey:@"New"] isEqual:@"Yes"]){
//                    [tasksList removeObject:dic];
//                }
//            }
//        }
        [tasksList removeObjectsInArray:addedManually];
        [addedManually removeAllObjects];
        for(NSMutableDictionary *dic in result){
            [tasksList addObject:dic];
            
        }
        _daySheetTable.reloadData;
        int yourSection = tasksList.count;
        if(tasksList.count>0){
            //        NSMutableDictionary *res=[tasksList objectAtIndex:yourSection-1];
            //        NSMutableArray *listCount=[res valueForKey:@"messages"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tasksList.count-1 inSection:0];
            [self.daySheetTable scrollToRowAtIndexPath:indexPath
                                      atScrollPosition:UITableViewScrollPositionTop
                                              animated:NO];
        }
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSMutableDictionary *res=[tasksList objectAtIndex:section];
//    NSMutableArray *listCount=[res valueForKey:@"messages"];
    return tasksList.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSMutableArray *listCount=[tasksList objectAtIndex:indexPath.section];
    //NSMutableDictionary *res=[tasksList objectAtIndex:indexPath.section];
  //  NSMutableArray *listCount=[res valueForKey:@"messages"];
    //NSMutableArray *listCount=[tasksList valueForKey:@"messages"];

    NSDictionary *dict=[tasksList objectAtIndex:indexPath.row];
    NSDictionary *addedDict=[dict valueForKey:@"added_by"];
    if([[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]] isEqual:@"0"]){
        
        DailySheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Daily3SheetTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dateCellbackgroundview.layer.cornerRadius=10;
        cell.dateCellbackgroundview.clipsToBounds=YES;
        
        
        cell.timeStamp.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"date"]];
        
        //cell.taskTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]];
        
        
        
        return cell;
    }
    else if(_whosWorksheet==[NSString stringWithFormat:@"%@",[addedDict valueForKey:@"id"]]){
    
    DailySheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailySheetTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    cell.cellBgView.layer.cornerRadius=10;
    cell.cellBgView.clipsToBounds=YES;
    
    
    cell.timeStamp.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"time"]];
    
    cell.taskTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]];
   
   
    
    return cell;
    }else{
        
        DailySheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Daily2SheetTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.cellBgView.layer.cornerRadius=10;
        cell.cellBgView.clipsToBounds=YES;
        cell.addedImage.layer.cornerRadius=cell.addedImage.frame.size.width/2;
        cell.addedImage.clipsToBounds=YES;
        
        cell.timeStamp.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"time"]];
        
        cell.taskTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]];
        cell.addedName.text=[NSString stringWithFormat:@"%@ %@",[addedDict valueForKey:@"fname"],[addedDict valueForKey:@"lname"]];
        cell.timeStamp.textAlignment=NSTextAlignmentRight;
        [cell.addedImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[addedDict valueForKey:@"image"]]] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.addedImage setContentMode:UIViewContentModeScaleAspectFit];

        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSMutableDictionary *header= [tasksList objectAtIndex:section];
//    NSString *string =[NSString stringWithFormat:@"%@",[header valueForKey:@"date"]];
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 45;
//}
- (IBAction)sendBtnAction:(id)sender {
    if(_messageTxtView.text.length>0){
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:_messageTxtView.text forKey:@"message"];
   
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                   [df setDateFormat:@"dd/mm/yyyy"];
                    NSString* temp = [[NSString alloc] init];
                    temp = [df stringFromDate:[NSDate date]];
                    NSLog(@"date i required %@", temp);
    [dic setValue:temp forKey:@"date"];

                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"hh:mm a"];
                    NSString* time = [[NSString alloc] init];
                    time = [dateFormatter stringFromDate:[NSDate date]];
                    NSLog(@"time i required %@", temp);
    [dic setValue:time forKey:@"time"];

    
        NSMutableDictionary *user=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *LoginUser=[[NSUserDefaults standardUserDefaults ]valueForKey:@"USER"];
        [user setObject:[NSString stringWithFormat:@"%@",[LoginUser valueForKey:@"id"]] forKey:@"id"];
        [user setObject:[LoginUser valueForKey:@"fname"] forKey:@"fname"];
        [user setObject:[LoginUser valueForKey:@"lname"] forKey:@"lname"];
        [user setObject:[LoginUser valueForKey:@"image"] forKey:@"image"];

    [dic setValue:user forKey:@"added_by"];
        
        NSMutableDictionary *Ldic =[tasksList lastObject];
    [dic setValue:[NSString stringWithFormat:@"%@",[Ldic valueForKey:@"id"]] forKey:@"id"];
    [dic setValue:@"Yes" forKey:@"New"];
[addedManually addObject:dic];
        [tasksList addObjectsFromArray:addedManually];
    [_daySheetTable reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tasksList.count-1 inSection:0];
        [self.daySheetTable scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:NO];
       callGoingOn=YES;
    [self makePostWithOutHUDCallForPage:ADDTOWORKSHEET withParams:@{@"employee_id":_whosWorksheet,@"message":_messageTxtView.text,@"added_by":_addedBy} withRequestCode:100];
        _messageTxtView.text=@"";

    }

}




@end
