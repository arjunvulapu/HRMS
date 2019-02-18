//
//  ProjectDetailVC.m
//  HRMSystem
//
//  Created by Apple on 09/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ProjectDetailVC.h"
#import "ProjectCell.h"
#import "LeadCollectionViewCell.h"
#import "TeamCollectionViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "MemberInfoViewController.h"
#import "TaskDetailVC.h"
@interface ProjectDetailVC ()
{
    NSMutableArray *taskList;
    NSDictionary *Lead;
    NSMutableArray *team;
}
@end

@implementation ProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    taskList=[[NSMutableArray alloc] init];
    [self addbackground:self.bgView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
     //   [self makePostCallForPage:PROJECTS withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
    [self todoBtnAction:nil];
    //    [self addTopCornerRadius:_todoBtn];
    //    [self addTopCornerRadius:_doingBtn];
    //    [self addTopCornerRadius:_doneBtn];
    _vcTitle.text=[NSString stringWithFormat:@"%@",[_projectDetials valueForKey:@"title"]];
    
    _ptitle.text=[NSString stringWithFormat:@"%@",[_projectDetials valueForKey:@"title"]];
    _clientName.text=[NSString stringWithFormat:@"%@",[[_projectDetials valueForKey:@"client"] valueForKey:@"name"]];
    _projectDescTxtView.text=[NSString stringWithFormat:@"%@",[_projectDetials valueForKey:@"description"] ];
    _startDate.text=[NSString stringWithFormat:@"%@",[_projectDetials valueForKey:@"start_date"] ];
    _endDate.text=[NSString stringWithFormat:@"%@",[_projectDetials valueForKey:@"end_date"] ];
    team=[_projectDetials valueForKey:@"team"];
    Lead=[_projectDetials valueForKey:@"leader"];
    taskList=[[_projectDetials valueForKey:@"tasks"] valueForKey:@"todo"];
    [_projectDescTxtView setTextAlignment:NSTextAlignmentCenter];
    [_ptitle setTextAlignment:NSTextAlignmentCenter];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //    [_todoBtn setRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:10];
    //
    //    [_doingBtn setRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:10];
    //
    //    [_doneBtn setRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:10];
    //    [_projectsTable setRoundedCorners:UIRectCornerBottomRight|UIRectCornerTopRight|UIRectCornerBottomLeft radius:10];
    //
    _projectsTable.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.5];
    //
    //    // [self addBottomCornerRadius:_bottomView];
    //    [self.view setNeedsDisplay];
    _todoBtn.layer.cornerRadius=10;
    _todoBtn.clipsToBounds=YES;
    _doingBtn.layer.cornerRadius=10;
    _doingBtn.clipsToBounds=YES;
    _doneBtn.layer.cornerRadius=10;
    _doneBtn.clipsToBounds=YES;
    _projectsTable.layer.cornerRadius=10;
    _projectsTable.clipsToBounds=YES;
    [_projectsTable reloadData];
    //    self.leadCollectionViewHeight.constant = self.leadCollectionView.contentSize.height;
    //    self.teamCollectionViewHeight.constant = self.teamCollectionView.contentSize.height;
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if(reqeustCode==10){
        taskList=result;
        _projectsTable.reloadData;
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
    
    //    return notificationList.count;
    
    return taskList.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.bgView.layer.cornerRadius=10;
    cell.bgView.clipsToBounds=YES;
    cell.bgView.backgroundColor=[UIColor whiteColor];
    cell.contentView.backgroundColor =[UIColor clearColor];
    NSDictionary *dict=[taskList objectAtIndex:indexPath.row];
    
    cell.Ptitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];
    
    // cell.Ptitle.text=@"HRMS";
    
    //    cell.nMsg.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"description"]?[dict valueForKey:@"description"]:@"Notification Description"];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskDetailVC *NDVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TaskDetailVC"];
    NDVC.taskDetails=[taskList objectAtIndex:indexPath.row];
    NDVC.ProjectName=[_projectDetials valueForKey:@"title"];
    [self.navigationController pushViewController:NDVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
    [self.projectsTable  layoutIfNeeded];
    self.taskTableViewHeight.constant = self.projectsTable.contentSize.height;
    [self addcellAnimation:cell];
}
- (IBAction)todoBtnAction:(id)sender {
    self.todoBtn.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.5];
    self.doingBtn.backgroundColor =[UIColor clearColor];
    self.doneBtn.backgroundColor =[UIColor clearColor];
    [self.todoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    taskList=[[_projectDetials valueForKey:@"tasks"] valueForKey:@"todo"];
    [_projectsTable reloadData];
    [self.projectsTable  layoutIfNeeded];
    self.taskTableViewHeight.constant = self.projectsTable.contentSize.height;
}

- (IBAction)doingBtnAction:(id)sender {
    self.doingBtn.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.5];
    self.todoBtn.backgroundColor =[UIColor clearColor];
    self.doneBtn.backgroundColor =[UIColor clearColor];
    [self.todoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    taskList=[[_projectDetials valueForKey:@"tasks"] valueForKey:@"doing"];
    [_projectsTable reloadData];
    [self.projectsTable  layoutIfNeeded];
    self.taskTableViewHeight.constant = self.projectsTable.contentSize.height;

}

- (IBAction)doneBtnAction:(id)sender {
    self.doneBtn.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.5];
    self.doingBtn.backgroundColor =[UIColor clearColor];
    self.todoBtn.backgroundColor =[UIColor clearColor];
    [self.todoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    taskList=[[_projectDetials valueForKey:@"tasks"] valueForKey:@"done"];
    [_projectsTable reloadData];
    [self.projectsTable  layoutIfNeeded];
    self.taskTableViewHeight.constant = self.projectsTable.contentSize.height;

    
    //    [_projectsTable setRoundedCorners:UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerBottomLeft radius:60];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma  Collection view Delegate&Data Souce methods..


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _leadCollectionView) {
        
        
        return 1;
    }
    else if (collectionView == _teamCollectionView){
        
        return team.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
{
    
    if (collectionView == _leadCollectionView) {
        self.leadCollectionViewHeight.constant = self.leadCollectionView.contentSize.height;
        LeadCollectionViewCell *cell=[_leadCollectionView dequeueReusableCellWithReuseIdentifier:@"LeadCollectionViewCell" forIndexPath:indexPath];
        
        // cell.backgroundColor=[UIColor blueColor];
        
        cell.leadImage.layer.cornerRadius= cell.leadImage.frame.size.height/2;
        cell.leadImage.clipsToBounds=YES;
        [cell.leadImage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
        
        [cell.leadImage setImageWithURL:[Lead valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        return cell;
    }
    else if (collectionView == _teamCollectionView)
    {
        self.teamCollectionViewHeight.constant = self.teamCollectionView.contentSize.height;
        
        TeamCollectionViewCell *cell=[_teamCollectionView dequeueReusableCellWithReuseIdentifier:@"TeamCollectionViewCell" forIndexPath:indexPath];
        cell.teamImage.layer.cornerRadius= cell.teamImage.frame.size.height/2;
        cell.teamImage.clipsToBounds=YES;
        //cell.backgroundColor=[UIColor greenColor];
        NSDictionary *dic=[team objectAtIndex:indexPath.row];
        [cell.teamImage setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.teamImage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
        return cell;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MemberInfoViewController *NDVC=[self.storyboard instantiateViewControllerWithIdentifier:@"MemberInfoViewController"];
    NDVC.member_Id=[[team objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:NDVC animated:YES];
}


@end
