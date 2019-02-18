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
#import "FTPopOverMenu/FTPopOverMenu.h"
#import "SRAlertView/SRAlertView.h"
//#import "IQKeyboardManager.h"
//#import "MSSKeyboardManager.h"
@interface DailyWorkSheetViewController ()<UITextViewDelegate>
{
    NSMutableArray *tasksList,*listofSearchEmployee,*addedManually, *newList;
    NSTimer *chatTimer;
    BOOL callGoingOn;
    NSString *selectedStr;
    NSString *actionType;
    NSString *selDel;
    UIRefreshControl *refreshControl;
}
@end

@implementation DailyWorkSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTheChat)
                  forControlEvents:UIControlEventValueChanged];
    _daySheetTable.refreshControl=self.refreshControl;
   // [[IQKeyboardManager sharedManager] setEnableAutoToolbar:false];
//    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:50];
    actionType=@"";
    selectedStr=@"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    // Do any additional setup after loading the view.
    _commentView.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.2];
    self.messageTxtView.text=@"";
    [self addbackground:_bgView];
    tasksList=[[NSMutableArray alloc] init];
    listofSearchEmployee=[[NSMutableArray alloc] init];
    addedManually=[[NSMutableArray alloc] init];
    _daySheetTable.delegate=self;
    _daySheetTable.dataSource=self;
    self.commentView.layer.cornerRadius=5;
    self.commentView.clipsToBounds=YES;
    self.messageTxtView.layer.cornerRadius=5;
    self.messageTxtView.clipsToBounds=YES;
    self.messageTxtView.delegate=self;
    self.messageTxtView.placeholder = @"Enter Task";
    self.messageTxtView.placeholderTextColor = [UIColor lightGrayColor];
    
    [self makePostCallForPage:WORKSHEETLIST withParams:@{@"employee_id":_whosWorksheet} withRequestCode:10];
    _workSheetTitle.text=[NSString stringWithFormat:@"%@-Work Sheet",_Fname];
//    [chatTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    callGoingOn=YES;
    chatTimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    _msgViewTop.constant=17;
    _commentView.hidden=YES;
    


}
-(void)refreshTheChat{
    [self makePostWithOutHUDCallForPage:WORKSHEETLIST withParams:@{@"employee_id":_whosWorksheet} withRequestCode:10];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [chatTimer invalidate];

    if([_from isEqualToString:@"NOTIFICATION"]){
        [APP_DELEGATE afterLoginSucess];
    }
}
- (void)reloadData
{
    // Reload table data
    [self.daySheetTable reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
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

        tasksList=[[NSMutableArray alloc] init];
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
    } else if(reqeustCode==110){
        callGoingOn=NO;
        for(NSMutableDictionary *dic in result){
            [tasksList addObject:dic];
            
        }
        
        [self reloadData];
//        _daySheetTable.reloadData;
        int yourSection = tasksList.count;
//        if(tasksList.count>0){
//            //        NSMutableDictionary *res=[tasksList objectAtIndex:yourSection-1];
//            //        NSMutableArray *listCount=[res valueForKey:@"messages"];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tasksList.count-1 inSection:0];
//            [self.daySheetTable scrollToRowAtIndexPath:indexPath
//                                      atScrollPosition:UITableViewScrollPositionTop
//                                              animated:NO];
//        }
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
       // [tasksList removeObjectsInArray:addedManually];
//        if([addedManually count]>0){
//            NSInteger a=[tasksList count]+[addedManually count];
//            a=a-1;
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:a inSection:0];
//
//        [self.daySheetTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        }
        addedManually=[[NSMutableArray   alloc] init];
        newList=[[NSMutableArray   alloc] init];

        for(NSMutableDictionary *dic in result){
            [tasksList addObject:dic];
            [newList addObject:dic];
        }
//        if(newList.count>0){
//
//            NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:tasksList.count - 1 inSection:0];
//
//                [self.daySheetTable insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }
        if(newList.count>0){
        [_daySheetTable reloadData];
        }

        
//            [self.daySheetTable insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
   
            
//            addedManually=[[NSMutableArray   alloc] init];

            
//            [self.daySheetTable scrollToRowAtIndexPath:indexPathToInsert atScrollPosition:UITableViewScrollPositionBottom animated:YES];
 //       }
        //_daySheetTable.reloadData;
       
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSMutableDictionary *res=[tasksList objectAtIndex:section];
//    NSMutableArray *listCount=[res valueForKey:@"messages"];
    return tasksList.count+addedManually.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSMutableArray *listCount=[tasksList objectAtIndex:indexPath.section];
    //NSMutableDictionary *res=[tasksList objectAtIndex:indexPath.section];
  //  NSMutableArray *listCount=[res valueForKey:@"messages"];
    //NSMutableArray *listCount=[tasksList valueForKey:@"messages"];
    NSDictionary *dict=[[NSDictionary alloc] init];
    if(indexPath.row<tasksList.count){
        dict=[tasksList objectAtIndex:indexPath.row];

    }else{
        dict=[addedManually objectAtIndex:indexPath.row-tasksList.count];

    }
    NSString *cmStr=@"";
    if([dict valueForKey:@"message_id"]!=nil){
    cmStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"message_id"]];
    }

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
        if(cmStr.length>0){
    DailySheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Daily4SheetTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    cell.cellBgView.layer.cornerRadius=10;
    cell.cellBgView.clipsToBounds=YES;
    
    
    cell.timeStamp.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"time"]];
    
    cell.taskTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]];
    cell.commentForMsgTxtView.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message_id"]];

   
    
    return cell;
        }else{
            
            DailySheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailySheetTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.cellBgView.layer.cornerRadius=10;
            cell.cellBgView.clipsToBounds=YES;
            
            
            cell.timeStamp.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"time"]];
            
            cell.taskTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]];
            
            
            
            return cell;
        }
    }else{
        if(cmStr.length>0){

            
                DailySheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Daily5SheetTableViewCell"];
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
            cell.commentForMsgTxtView.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message_id"]];

                [cell.addedImage setContentMode:UIViewContentModeScaleAspectFit];
                
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
    NSLog(@"%f",self.view.frame.size.height);
    if(_messageTxtView.text.length>0){
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:_messageTxtView.text forKey:@"message"];
    [dic setValue:selectedStr forKey:@"message_id"];

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
       // [tasksList addObjectsFromArray:addedManually];
    [_daySheetTable reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tasksList.count+addedManually.count-1 inSection:0];
        [self.daySheetTable scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:NO];
       callGoingOn=YES;
        [self makePostWithOutHUDCallForPage:ADDTOWORKSHEET withParams:@{@"employee_id":_whosWorksheet,@"message":_messageTxtView.text,@"message_id":selectedStr,@"added_by":_addedBy} withRequestCode:100];
        _messageTxtView.text=@"";
        selectedStr=@"";
        _msgViewTop.constant=17;
        _commentView.hidden=YES;
    }

}
-(void)openOptions:(UITextView *)sender
{
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
    
  
        [Item addObject:@"Delete"];
     [Item addObject:@"Comment"];
    
    [FTPopOverMenu showForSender:sender
                   withMenuArray:Item
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
//                           self->selectedProject = [self->projectList objectAtIndex:selectedIndex];
//                           self->_projectNameTxtField.text=[self->selectedProject valueForKey:@"title"];
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                           //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                           //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
    
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                          {
                                              // delete ...
                                              NSDictionary *dict=[self->tasksList objectAtIndex:indexPath.row];
                                              self->selDel=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                                              self->selectedStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
    SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"HRMSystem"
                                                          icon:nil
                                                           message:@"Please Conform To Delete"
                                                leftActionTitle:@"Sure"
                                                    rightActionTitle:@"Cancel"
                                                 animationStyle:SRAlertViewAnimationZoomSpring
                                                                                                 delegate:self];
                                              [alertView show];
                                          }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@" Reply " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                  {
                                      self->actionType=@"replay";
                                      NSDictionary *dict=[[NSDictionary alloc] init];
                                      if(indexPath.row<tasksList.count){
                                          dict=[tasksList objectAtIndex:indexPath.row];
                                          
                                      }else{
                                          dict=[addedManually objectAtIndex:indexPath.row-tasksList.count];
                                          
                                      }
//                                      NSDictionary *dict=[self->tasksList objectAtIndex:indexPath.row];
                                      self->selectedStr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]];
                                      _msgViewTop.constant=40;
                                      _commentLbl.text=selectedStr;
                                      _commentView.hidden=false;
                                      // edit ...
                                  }];
    edit.backgroundColor = [UIColor colorWithRed:0x2F/255.0 green:0x83/255.0 blue:0xFB/255.0 alpha:1];
    
    return @[deleteAction,edit];
}

- (void)alertViewDidSelectAction:(SRAlertViewActionType)actionType {
    NSLog(@"%zd", actionType);
    if(actionType==SRAlertViewActionTypeLeft){
        [tasksList removeObjectAtIndex:selDel.integerValue];
        [_daySheetTable reloadData];

            [self makePostWithOutHUDCallForPage:WORKSHEET_MESSAGE_DELETE withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"worksheet_id":selectedStr} withRequestCode:100];
       
    }
}
- (IBAction)commentBtnAction:(id)sender {
    selectedStr=@"";
    _msgViewTop.constant=17;
    _commentView.hidden=YES;
}
@end
