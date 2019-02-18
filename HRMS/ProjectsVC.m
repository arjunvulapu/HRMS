//
//  ProjectsVC.m
//  HRMSystem
//
//  Created by Apple on 05/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ProjectsVC.h"
#import "ProjectCell.h"
#import "UIView+RoundedCorners.h"
#import "ProjectDetailVC.h"
@interface ProjectsVC ()
{
    NSMutableArray *projectsList;
    NSDictionary *projectsResult;
}
@end

@implementation ProjectsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    projectsList=[[NSMutableArray alloc] init];
    [self addbackground:self.bgView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    [self makePostCallForPage:PROJECTS withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:10];
    [self todoBtnAction:nil];
//    [self addTopCornerRadius:_todoBtn];
//    [self addTopCornerRadius:_doingBtn];
//    [self addTopCornerRadius:_doneBtn];
    
  
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
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if(reqeustCode==10){
        projectsResult=result;
        projectsList=[projectsResult valueForKey:@"todo"];
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
    return projectsList.count;
    
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
        NSDictionary *dict=[projectsList objectAtIndex:indexPath.row];

        cell.Ptitle.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"title"]];
    if(indexPath.row==projectsList.count-1){
        [cell.contentView setRoundedCorners:UIRectCornerTopLeft radius:10];
    }
    if(indexPath.row==0){
        [cell.contentView setRoundedCorners:UIRectCornerTopRight radius:10];
    }
   // cell.Ptitle.text=@"HRMS";
    
    //    cell.nMsg.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"description"]?[dict valueForKey:@"description"]:@"Notification Description"];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectDetailVC *PDVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ProjectDetailVC"];
    PDVC.projectDetials=[projectsList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:PDVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}

- (IBAction)todoBtnAction:(id)sender {
    self.todoBtn.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.5];
    self.doingBtn.backgroundColor =[UIColor clearColor];
    self.doneBtn.backgroundColor =[UIColor clearColor];
    [self.todoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    projectsList=[projectsResult valueForKey:@"todo"];
    _projectsTable.reloadData;
}

- (IBAction)doingBtnAction:(id)sender {
    self.doingBtn.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.5];
    self.todoBtn.backgroundColor =[UIColor clearColor];
    self.doneBtn.backgroundColor =[UIColor clearColor];
    [self.todoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    projectsList=[projectsResult valueForKey:@"doing"];
    _projectsTable.reloadData;
}

- (IBAction)doneBtnAction:(id)sender {
    self.doneBtn.backgroundColor =[UIColor colorWithWhite:1.0 alpha:0.5];
    self.doingBtn.backgroundColor =[UIColor clearColor];
    self.todoBtn.backgroundColor =[UIColor clearColor];
    [self.todoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    projectsList=[projectsResult valueForKey:@"done"];
    _projectsTable.reloadData;


//    [_projectsTable setRoundedCorners:UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerBottomLeft radius:60];

}
-(UIView *)addTopCornerRadius:(UIView *)btn{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path  = maskPath.CGPath;
    btn.layer.mask = maskLayer;
    return btn;
}
-(void)addBottomCornerRadius:(UIView *)tb{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:tb.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = tb.bounds;
    maskLayer.path  = maskPath.CGPath;
    tb.layer.mask = maskLayer;
    
}
@end
