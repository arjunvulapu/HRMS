//
//  EmployeesViewController.m
//  HRMSystem
//
//  Created by Apple on 28/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "EmployeesViewController.h"
#import "EmployeesTableViewCell.h"
#import "DailyWorkSheetViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
@interface EmployeesViewController ()<UISearchBarDelegate>
{
    NSMutableArray *employeesList,*searchEmployeesList;
}
@end

@implementation EmployeesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    employeesList=[[NSMutableArray alloc] init];
    searchEmployeesList=[[NSMutableArray alloc] init];
    _searchBar.delegate=self;
    _employeesTableView.delegate=self;
    _employeesTableView.dataSource=self;
    [_employeesTableView setSeparatorEffect:UITableViewCellSeparatorStyleNone];
    [self addbackground:_bgView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
 
    [self makePostCallForPage:EMPLOYEEDETIALS withParams:@{} withRequestCode:10];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==10){
        employeesList=result;
        [_employeesTableView reloadData];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     if(self.searchBar.text.length>0){
         return searchEmployeesList.count;
     }else{
    return employeesList.count;    //count number of row from counting array hear cataGorry is An Array
     }
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EmployeesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeesTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.worksheetBtn.layer.cornerRadius=5;
    cell.worksheetBtn.clipsToBounds=YES;
    cell.bgView.layer.cornerRadius=10;
    cell.bgView.clipsToBounds=YES;
    NSDictionary *dict=[[NSDictionary alloc] init];
     if(self.searchBar.text.length>0){
    dict=[searchEmployeesList objectAtIndex:indexPath.row];
     }else{
         dict=[employeesList objectAtIndex:indexPath.row];

     }
    
    cell.employeeId.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"employee_code"]];
    
    cell.employeeName.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"designation"]];
    cell.emailLbl.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"company_email"]];
    cell.designationLbl.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"phone"]];
    cell.openWorkSheet = ^{
        DailyWorkSheetViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyWorkSheetViewController"];
        controller.addedBy=[Utils loggedInUserIdStr];
        controller.whosWorksheet=[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
        controller.Fname=[dict valueForKey:@"fname"];
        controller.Lname=[dict valueForKey:@"lname"];

        [self.navigationController pushViewController:controller animated:YES];
    };
    
    NSString *fullStr=[NSString stringWithFormat:@"%@ %@(%@)",[dict valueForKey:@"fname"],[dict valueForKey:@"lname"],[dict valueForKey:@"employee_code"]];
    NSString *nameStr=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"fname"],[dict valueForKey:@"lname"]];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullStr];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(nameStr.length,fullStr.length-nameStr.length)];
    [cell.userImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"image"]]] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.userImage.layer.cornerRadius=cell.userImage.frame.size.width/2;
    cell.userImage.clipsToBounds=YES;
    
    [cell.employeeId setAttributedText:string];
    cell.employeeId.textAlignment=NSTextAlignmentCenter;
    cell.employeeName.textAlignment=NSTextAlignmentCenter;
    cell.emailLbl.textAlignment=NSTextAlignmentCenter;
    cell.designationLbl.textAlignment=NSTextAlignmentCenter;

    return cell;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    if(self.searchBar.text.length>0){
        searchEmployeesList=[[NSMutableArray alloc]init];
        
        //going=@"YES";
        
        NSString *se=[NSString stringWithFormat:@"%@",self.searchBar.text];
        for(NSDictionary *dict in employeesList){
            //            NSLog(@"%@ ---- %@",dict.name_short,self.searchBar.text);
            NSString *strFL = [NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"fname"],[dict valueForKey:@"lname"]];
            NSString *empId = [NSString stringWithFormat:@"%@",[dict valueForKey:@"employee_code"]];

            NSRange range = [strFL rangeOfString:se options:NSCaseInsensitiveSearch];
            NSRange rangeid = [empId rangeOfString:se options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                NSLog(@"string contains!");
                [searchEmployeesList addObject:dict];
            }else if (rangeid.location != NSNotFound) {
                NSLog(@"string contains!");
                [searchEmployeesList addObject:dict];
            }
            
            
            
            //            else {
            //                NSRange range = [dict.name_long rangeOfString:se options:NSCaseInsensitiveSearch];
            //                if (range.location != NSNotFound) {
            //                    NSLog(@"string contains bla!");
            //                    [listofSearchCurrency addObject:dict];
            //                }
            //                NSLog(@"string first does not contain bla");
            //            }
            
        }
    }
    
    [_employeesTableView reloadData];
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder ];
    
}
@end
