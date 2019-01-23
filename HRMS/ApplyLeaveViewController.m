//
//  ApplyLeaveViewController.m
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ApplyLeaveViewController.h"
#import "StoryboardExampleViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "LeaveTypeCollectionViewCell.h"
@interface ApplyLeaveViewController ()
{
    NSMutableArray *leaveTypes;
    NSDictionary *selectedleaveType;
    int numberOfDays;
}
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;

    
@end

@implementation ApplyLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addbackground:self.backgroundView];
    
    self.startDateTxtField.text=@"";
    self.endDateTxtField.text=@"";
    self.typeOfLeave.text=@"";

    self.startDateTxtField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Select StartDate")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.endDateTxtField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Select EndDate")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.typeOfLeave.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Select LeaveType")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.submitBtn.layer.cornerRadius = self.submitBtn.frame.size.height/2;
    self.submitBtn.clipsToBounds = YES;
    self.submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.submitBtn.layer.borderWidth = 2;
    [self.submitBtn setTitle:Localized(@"SUBMIT") forState:UIControlStateNormal];
    
    _CommentTxtView.text=@"";
    _CommentTxtView.placeholder = Localized(@"Reason");
    _CommentTxtView.placeholderTextColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    self.tabBarController.navigationItem.title=@"Apply Leave";
    self.numberOfLeavesLbl.text=@"";
    [self makePostCallForPage:LEAVETYPES withParams:@{} withRequestCode:12];
    _leaveTypeSegment.selectedSegmentIndex=1;
    _endtimeBtn.hidden=YES;
    _endDateTxtField.hidden=YES;
    _toDateLbl.hidden=YES;
    _reasonTopValue.constant=12;
    _halfdaySegment.hidden=YES;
    _startDateTop.constant=12;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtnAction:(id)sender {
    if(_startDateTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Select StartDate")];
    }else if(_endDateTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Select EndDate")];
    }else if(!selectedleaveType){
        [self showErrorAlertWithMessage:Localized(@"Please Select LeaveType")];
    }else if(_CommentTxtView.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Comment")];
    }else{
    [self makePostCallForPage:APPLYLEAVE withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_type":[selectedleaveType valueForKey:@"id"],@"start_date":_startDateTxtField.text,@"end_date":_endDateTxtField.text,@"no_days":[NSString stringWithFormat:@"%d",numberOfDays],@"description":_CommentTxtView.text} withRequestCode:13];
}
    
}

- (IBAction)showDatePicker:(id)sender {
    
   
}
- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}
- (IBAction)startTimeBtnAction:(id)sender {
    StoryboardExampleViewController *vc = [[StoryboardExampleViewController alloc] initWithNibName:@"StoryboardExampleViewController" bundle:nil];
    vc.delegate=self;
    //    [self.navigationController pushViewController:vc animated:YES];
    //vc.datesShouldBeSelected=[[NSUserDefaults standardUserDefaults] objectForKey:@"SELECTEDDATES"];
    vc.completionBlock = ^(NSString *datesList) {
        //        self.area = area;
        //        self.shopAddressTxtField.text = self.area.title;
        NSLog(@"%@",datesList);
        [[NSUserDefaults standardUserDefaults] setObject:datesList forKey:@"SELECTEDDATES"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // _chooseYourDateTxtField.text=[datesList componentsJoinedByString:@","];
        self->_startDateTxtField.text=datesList;
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
    
}
- (IBAction)endTimeBtnAction:(id)sender {
    if(_startDateTxtField.text.length>0){
    StoryboardExampleViewController *vc = [[StoryboardExampleViewController alloc] initWithNibName:@"StoryboardExampleViewController" bundle:nil];
    vc.delegate=self;
    //    [self.navigationController pushViewController:vc animated:YES];
    //vc.datesShouldBeSelected=[[NSUserDefaults standardUserDefaults] objectForKey:@"SELECTEDDATES"];
    vc.completionBlock = ^(NSString *datesList) {
        //        self.area = area;
        //        self.shopAddressTxtField.text = self.area.title;
        NSLog(@"%@",datesList);
        [[NSUserDefaults standardUserDefaults] setObject:datesList forKey:@"SELECTEDDATES"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // _chooseYourDateTxtField.text=[datesList componentsJoinedByString:@","];
        self.endDateTxtField.text=datesList;
        self.dateFormatter1 = [[NSDateFormatter alloc] init];
        [ self.dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
        NSDate *date1 = [self.dateFormatter1 dateFromString:self->_startDateTxtField.text];
        NSDate *date2 = [self.dateFormatter1 dateFromString:self->_endDateTxtField.text];
        
        NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
        
         numberOfDays = secondsBetween / 86400;
        
        NSLog(@"There are %d days in between the two dates.", numberOfDays);
        self->_numberOfLeavesLbl.text =[NSString stringWithFormat:@"Your Applying  %d Days",numberOfDays+1];
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
    }else{
        [self showErrorAlertWithMessage:Localized(@"Please Select StartDate")];
    }
}
- (IBAction)typeOfLeaveBtnAction:(id)sender {
    [self makePostCallForPage:LEAVETYPES withParams:@{} withRequestCode:12];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==12){
        leaveTypes = [[NSMutableArray alloc] init];
        leaveTypes = result;
        
//        FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
//        configuration.menuRowHeight = 40;
//        configuration.menuWidth = self.typeOfLeaveBtn.frame.size.width;
//        configuration.textColor = [UIColor blackColor];
//        configuration.textFont = [UIFont boldSystemFontOfSize:14];
//        configuration.tintColor = [UIColor whiteColor];
//        configuration.borderColor = [UIColor lightGrayColor];
//        configuration.borderWidth = 0.5;
//        configuration.textAlignment = UITextAlignmentCenter;
//        NSMutableArray *Item=[[NSMutableArray alloc] init];
//
//        for(NSDictionary *dict in result){
//            [Item addObject:[dict valueForKey:@"title"]];
//        }
//
//        [FTPopOverMenu showForSender:_typeOfLeaveBtn
//                       withMenuArray:Item
//                           doneBlock:^(NSInteger selectedIndex) {
//
//                               NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
//                               self->selectedleaveType=[leaveTypes objectAtIndex:selectedIndex];
//                               self->_typeOfLeave.text=[selectedleaveType valueForKey:@"title"];
//                           } dismissBlock:^{
//
//                               NSLog(@"user canceled. do nothing.");
//
//                               //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
//                               //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
//
//                           }];
        [_leavesCollectionView reloadData];
    }else if (reqeustCode==13){
        NSLog(@"%@",result);
        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            [self.tabBarController setSelectedIndex:0];
            [self showSuccessMessage:[result valueForKey:@"message"]];
            
        }
    }
}
- (IBAction)leaveTypeSegmentAction:(id)sender {
    if(_leaveTypeSegment.selectedSegmentIndex==0){
        _endtimeBtn.hidden=YES;
        _endDateTxtField.hidden=YES;
        _toDateLbl.hidden=YES;
        _reasonTopValue.constant=12;
        _halfdaySegment.hidden=NO;
        _startDateTop.constant=60;
    }else  if(_leaveTypeSegment.selectedSegmentIndex==1){
        _endtimeBtn.hidden=YES;
        _endDateTxtField.hidden=YES;
        _toDateLbl.hidden=YES;
        _reasonTopValue.constant=12;
        _halfdaySegment.hidden=YES;
        _startDateTop.constant=12;
    }else  if(_leaveTypeSegment.selectedSegmentIndex==2){
        _endtimeBtn.hidden=NO;
        _endDateTxtField.hidden=NO;
        _toDateLbl.hidden=NO;
        _reasonTopValue.constant=64;
        _halfdaySegment.hidden=YES;
        _startDateTop.constant=12;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return leaveTypes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LeaveTypeCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LeaveTypeCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dic=[leaveTypes objectAtIndex:indexPath.row];
    ccell.leaveTitleLbl.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"title"]];
    return ccell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
        return CGSizeMake((collectionView.frame.size.width)/3, collectionView.frame.size.height);
    
    
}
- (IBAction)halfDaySegmentAction:(id)sender {
}
@end
