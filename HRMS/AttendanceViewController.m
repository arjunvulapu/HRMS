//
//  AttendanceViewController.m
//  HRMSystem
//
//  Created by Apple on 22/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AttendanceViewController.h"
#import "FSCalendarExtensions.h"
#import "AttendanceCollectionViewCell.h"
#import "FTPopOverMenu/FTPopOverMenu.h"
@interface AttendanceViewController ()<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance>
{
    NSMutableArray *attendanceList;
    NSDictionary *attendanceResult;
    NSMutableDictionary *userdic;
    NSString *selectedDatestr;
    
    NSDictionary *selectedDateInfo;
    
    
    NSMutableArray *AvailableList;
    NSMutableArray *SelectedMonthDict;

}
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatterForBtn;

@property (strong, nonatomic) NSCalendar *gregorianCalendar;
@property (strong, nonatomic) NSArray<NSString *> *datesShouldNotBeSelected;
@property (strong, nonatomic) NSArray<NSString *> *datesShouldBeSelected;
@property (assign, nonatomic) BOOL           lunar;

@property (strong, nonatomic) NSArray<NSString *> *datesWithEvent;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;
@property (strong, nonatomic) NSDateFormatter *dateFormatter3;

@end

@implementation AttendanceViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSLocale *chinese = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        
        self.dateFormatter1 = [[NSDateFormatter alloc] init];
        //self.dateFormatter1.locale = chinese;
        self.dateFormatter1.dateFormat = @"dd-MM-yyyy";
        
        self.dateFormatter2 = [[NSDateFormatter alloc] init];
        self.dateFormatter2.locale = chinese;
        self.dateFormatter2.dateFormat = @"yyyy-MM-dd";
        
        self.calanderView.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesUpperCase;
        
        self.datesShouldNotBeSelected = @[@"2016/08/07",
                                          @"2016/09/07",
                                          @"2016/10/07",
                                          @"2016/11/07",
                                          @"2016/12/07",
                                          @"2016/01/07",
                                          @"2016/02/07"];
        self.datesShouldBeSelected = @[@"2016/08/07",
                                       @"2016/09/07",
                                       @"2016/10/07",
                                       @"2016/11/07",
                                       @"2016/12/07",
                                       @"2016/01/07",
                                       @"2016/02/07"];
        
        for(NSDate *date in self.datesShouldBeSelected){
            //            [self calendar:self.calendar appearance:self.calendar.appearance eventSelectionColorsForDate:date];
        }
        
        self.datesWithEvent = @[@"2016-12-03",
                                @"2016-12-07",
                                @"2016-12-15",
                                @"2016-12-25"];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    selectedDatestr=@"";
    attendanceList=[[NSMutableArray  alloc] init];
    self.dateFormatter3 = [[NSDateFormatter alloc] init];
    self.dateFormatter3.dateFormat = @"dd-MM-yyyy";
    [self addbackground:_backgroundView];
    _calanderView.backgroundColor=[UIColor clearColor];
    AvailableList=[[NSMutableArray  alloc] init];
    _showingDateBtn.layer.borderWidth=1;
    _showingDateBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    _showingDateBtn.layer.cornerRadius=10;
    _showingDateBtn.clipsToBounds=YES;
     [self setTheme:1];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    _calanderView.dataSource = self;
    _calanderView.delegate = self;
    self.calanderView.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesUpperCase;
//    self.datesShouldNotBeSelected = @[@"01-01-2019",
//                                      @"05-01-2019",
//                                      @"01-01-2019",
//                                      @"09-01-2019",
//                                      @"20-01-2019",
//                                      @"22-01-2019",
//                                      @"04-01-2019"];
 userdic=[[NSUserDefaults standardUserDefaults ]valueForKey:@"USER"];
    NSDate *date = [NSDate date]; //I'm using this just to show the this is how you convert a date
    
    _dateFormatterForBtn = [[NSDateFormatter alloc] init];
//    [df setDateStyle:NSDateFormatterLongStyle]; // day, Full month and year
//    [df setTimeStyle:NSDateFormatterNoStyle];  // nothing
    [_dateFormatterForBtn setDateFormat:@"MMMM yyyy"];
    NSString *dateString = [_dateFormatterForBtn stringFromDate:date];
    [_showingDateBtn setTitle:dateString forState:UIControlStateNormal];
    NSInteger years = [_calanderView yearOfDate:_calanderView.currentPage];
    NSInteger month = [_calanderView monthOfDate:_calanderView.currentPage];
    [self makePostCallForPage:ATTENDANCE withParams:@{@"employee_code":[userdic valueForKey:@"employee_code"],@"month":[NSString stringWithFormat:@"%02ld",(long)month],@"year":[NSString stringWithFormat:@"%ld",(long)years]} withRequestCode:14];
    _calanderView.placeholderType=FSCalendarPlaceholderTypeNone;
}
- (void)setTheme:(NSInteger)theme
{
    if (theme != theme) {
        theme = theme;
        switch (theme) {
            case 0: {
                _calanderView.appearance.weekdayTextColor = FSCalendarStandardTitleTextColor;
                _calanderView.appearance.headerTitleColor = FSCalendarStandardTitleTextColor;
                _calanderView.appearance.eventDefaultColor = FSCalendarStandardEventDotColor;
                _calanderView.appearance.selectionColor = FSCalendarStandardSelectionColor;
                _calanderView.appearance.headerDateFormat = @"MMMM yyyy";
                _calanderView.appearance.todayColor = FSCalendarStandardTodayColor;
                _calanderView.appearance.borderRadius = 1.0;
                _calanderView.appearance.headerMinimumDissolvedAlpha = 0.2;
                break;
            }
            case 1: {
                _calanderView.appearance.weekdayTextColor = FSCalendarStandardTitleTextColor;
                _calanderView.appearance.headerTitleColor = FSCalendarStandardTitleTextColor;
                _calanderView.appearance.eventDefaultColor = FSCalendarStandardEventDotColor;
                _calanderView.appearance.selectionColor = [UIColor blackColor];
                //_calendar.appearance.headerDateFormat = @"yyyy-MM";
                _calanderView.appearance.headerDateFormat = @"MMMM yyyy";
                _calanderView.appearance.todayColor = FSCalendarStandardTodayColor;
                _calanderView.appearance.borderRadius = 0.0;
                _calanderView.appearance.headerMinimumDissolvedAlpha = 0.0;
                _calanderView.placeholderType = FSCalendarPlaceholderTypeNone;
                _calanderView.calendarHeaderView.hidden=YES;
                break;
            }
            case 2: {
                _calanderView.appearance.weekdayTextColor = [UIColor redColor];
                _calanderView.appearance.headerTitleColor = [UIColor redColor];
                _calanderView.appearance.eventDefaultColor = [UIColor greenColor];
                _calanderView.appearance.selectionColor = [UIColor blueColor];
                _calanderView.appearance.headerDateFormat = @"yyyy/MM";
                _calanderView.appearance.todayColor = [UIColor orangeColor];
                _calanderView.appearance.borderRadius = 0;
                _calanderView.appearance.headerMinimumDissolvedAlpha = 1.0;
                break;
            }
            default:
                break;
        }
        
    }
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==14){
        if(AvailableList.count==0){
        [self makePostCallForPage:ATTENDANCEMONTHSLUST withParams:@{@"employee_code":[userdic valueForKey:@"employee_code"]} withRequestCode:15];
        }

        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            attendanceResult=result;
//            _calanderView.minimumDate = [self.dateFormatter1 dateFromString:[attendanceResult valueForKey:@"start_date"]];
           // [self minimumDateForCalendar:_calanderView];
            if([result  valueForKey:@"attendance"]){
            attendanceList=[result  valueForKey:@"attendance"];
            }else{
                attendanceList=[[NSMutableArray alloc] init];
            }
            [_calanderView reloadData];
            [_attendanceCollectionView reloadData];
        }
    }else if(reqeustCode==15){
        AvailableList=result;
        
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
#pragma mark - FSCalendarDataSource

//- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
//{
//    return [self.gregorianCalendar isDateInToday:date] ? @"今天" : nil;
//}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    if (!_lunar) {
        return nil;
    }
    //    return [self.lunarFormatter stringFromDate:date];
    return nil;
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    if ([self.datesWithEvent containsObject:[self.dateFormatter2 stringFromDate:date]]) {
        return 1;
    }
    return 0;
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    //return [self.dateFormatter1 dateFromString:@"2016/10/01"];
    if([attendanceResult valueForKey:@"start_date"]){
        return [self.dateFormatter1 dateFromString:[attendanceResult valueForKey:@"start_date"]];
        }
    return nil;
    //return [self.dateFormatter1 dateFromString:@"01-03-2016"];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [NSDate date];
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    BOOL shouldSelect = ![_datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]];
    if (!shouldSelect) {
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Monasabat" message:[NSString stringWithFormat:@"Booking not available on %@  to be selected",[self.dateFormatter1 stringFromDate:date]] preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        //        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        NSLog(@"Should select date %@",[self.dateFormatter1 stringFromDate:date]);
    }
    return shouldSelect;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if (![_datesShouldBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
        self.dateFormatter1 = [[NSDateFormatter alloc] init];
        [ self.dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
        NSLog(@"did select date %@",[self.dateFormatter1 stringFromDate:date]);
      //  [datesArr addObject:[self.dateFormatter1 stringFromDate:date]];
        selectedDatestr=[self.dateFormatter1 stringFromDate:date];
        if(attendanceList.count>0){
            for(NSDictionary *dayRec in attendanceList){
                if([[dayRec valueForKey:@"date"] isEqualToString:selectedDatestr]){
                   
                            selectedDateInfo = dayRec;
                }
            }
        }
        [_attendanceCollectionView reloadData];
        if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
            [calendar setCurrentPage:date animated:YES];
        }
    }
}
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter1 stringFromDate:date]);
   // [datesArr removeObject:[self.dateFormatter1 stringFromDate:date]];
}
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSInteger years = [_calanderView yearOfDate:_calanderView.currentPage];
    NSInteger month = [_calanderView monthOfDate:_calanderView.currentPage];
    [self makePostCallForPage:ATTENDANCE withParams:@{@"employee_code":[userdic valueForKey:@"employee_code"],@"month":[NSString stringWithFormat:@"%02ld",(long)month],@"year":[NSString stringWithFormat:@"%ld",(long)years]} withRequestCode:14];
    NSLog(@"did change to page %@",[self.dateFormatter1 stringFromDate:calendar.currentPage]);
    NSString *dateString = [_dateFormatterForBtn stringFromDate:calendar.currentPage];
    [_showingDateBtn setTitle:dateString forState:UIControlStateNormal];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
   // _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleOffsetForDate:(NSDate *)date
{
    if ([self calendar:calendar subtitleForDate:date]) {
        return CGPointZero;
    }
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    [ self.dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
    if ([_datesShouldBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
        return CGPointMake(0, -2);
    }
    //    if ([_datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
    //
    //        return CGPointZero;
    //    }
    return CGPointZero;
}

- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventOffsetForDate:(NSDate *)date
{
    if ([self calendar:calendar subtitleForDate:date]) {
        return CGPointZero;
    }
    if ([_datesWithEvent containsObject:[self.dateFormatter2 stringFromDate:date]]) {
        return CGPointMake(0, -10);
    }
    return CGPointZero;
}

//- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventSelectionColorsForDate:(nonnull NSDate *)date
//{
//
//    if ([self calendar:calendar subtitleForDate:date]) {
//
//        return @[[UIColor redColor]];
//    }
//    if ([_datesWithEvent containsObject:[self.dateFormatter2 stringFromDate:date]]) {
//        return @[[UIColor whiteColor]];
//    }
//    if ([_datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
//        return @[[UIColor redColor]];
//    }
//    return nil;
//}
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date;{
    return [UIColor whiteColor];
}
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date;
{
    
    if(attendanceList.count>0){

        for(NSDictionary *dayRec in attendanceList){
            
            if([[dayRec valueForKey:@"date"] isEqualToString:[self.dateFormatter1 stringFromDate:date]]){
                if([[dayRec valueForKey:@"status"] isEqual:@"Holiday"]){
                    return [UIColor blackColor];
//                   return [UIColor colorWithRed:22/255.0f green:113/255.0f  blue:28/255.0f  alpha:1.0];
                }else  if([[dayRec valueForKey:@"status"] isEqual:@"WeeklyOff"]){
                    return [UIColor orangeColor];
                }
                else if([[dayRec valueForKey:@"status"] isEqual:@"Present"]||[[dayRec valueForKey:@"status"] isEqual:@"WeeklyOff Present"]){
                    return [UIColor colorWithRed:22/255.0f green:113/255.0f  blue:28/255.0f  alpha:1.0];
                }
//                else if([[dayRec valueForKey:@"status"] isEqual:@"WeeklyOff"]){
//                    return [UIColor yellowColor];
//                }
                else if([[dayRec valueForKey:@"status"] isEqual:@"Absent (No OutPunch)"]||[[dayRec valueForKey:@"status"] isEqual:@"Absent"]){
//                    return [UIColor colorWithRed:204/255.0f  green:16/255.0f  blue:16/255.0f  alpha:1.0];
                    return [UIColor redColor];
                }
            }else if([NSDate date] == date){
                return [UIColor clearColor];
            }
        }
    }
        
    
    
     return nil;
}

//- (nullable NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date;
//{
//    if ([_datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
//        //        [self calendar:self.calendar appearance:self.calendar.appearance eventSelectionColorsForDate:date];
//
//        return [UIColor lightGrayColor];
//
//    }
//    return nil;
//}
//

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(selectedDatestr.length==0&&attendanceResult.count!=0){
        return 7;
    }
    else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"Absent"])
    {
    // [self showErrorAlertWithMessage:[NSString stringWithFormat:@"On %@ Your Absent",[selectedDateInfo valueForKey:@"date"]]];
     return 1+1+7;
    }else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"Holiday"])
    {
     //[self showErrorAlertWithMessage:[NSString stringWithFormat:@"On %@ Company Have Holiday",[selectedDateInfo valueForKey:@"date"]]];
     return 1+1+7;
    }else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"WeeklyOff"])
    {
    // [self showErrorAlertWithMessage:[NSString stringWithFormat:@"On %@ Company Have WeeklyOff",[selectedDateInfo valueForKey:@"date"]]];
     return 1+1+7;
    }
   else  if([selectedDateInfo valueForKey:@"punch_records"]){
        NSMutableArray *puncRecords=[selectedDateInfo valueForKey:@"punch_records"];
        return puncRecords.count+3+7+1;
    }else{
        
    return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AttendanceCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AttendanceCollectionViewCell" forIndexPath:indexPath];
    ccell.infoLbl.text=[NSString stringWithFormat:@"Arjun %ld",(long)indexPath.row];
    ccell.infoLbl.textAlignment=NSTextAlignmentCenter;
    ccell.infoLbl.textColor=[UIColor whiteColor];
   // if(selectedDatestr.length==0){
        NSDictionary *hist=[attendanceResult valueForKey:@"total"];
        NSString *rupee=@"\u20B9";
        if(indexPath.row==0){
            ccell.infoLbl.text=[NSString stringWithFormat:@"For %@",_showingDateBtn.titleLabel.text];
            ccell.contentView.backgroundColor=[UIColor lightTextColor];
        }
        else if(indexPath.row==1){
            ccell.infoLbl.text=[NSString stringWithFormat:@"Present : %@ Days",[hist valueForKey:@"present"]];
        }else  if(indexPath.row==2){
            ccell.infoLbl.text=[NSString stringWithFormat:@"Absent : %@ Days",[hist valueForKey:@"absent"]];
        }else  if(indexPath.row==3){
            ccell.infoLbl.text=[NSString stringWithFormat:@"Late Days : %@ Days",[hist valueForKey:@"late_days"]];
        }else  if(indexPath.row==4){
            ccell.infoLbl.text=[NSString stringWithFormat:@"Late Time : %@ ",[hist valueForKey:@"late_time"]];
        }else  if(indexPath.row==5){
            ccell.infoLbl.text=[NSString stringWithFormat:@"LOP/Day : %@%@",rupee,[hist valueForKey:@"approx_lop"]];
        }else if(indexPath.row==6){
            ccell.infoLbl.text=[NSString stringWithFormat:@"LOP : %@%@",rupee,[NSString stringWithFormat:@"%d",[[hist valueForKey:@"approx_lop"] intValue]*[[hist valueForKey:@"absent"] intValue]]];

        }else if(indexPath.row==7){
            ccell.infoLbl.text=[NSString stringWithFormat:@"ON %@",selectedDatestr];
            ccell.contentView.backgroundColor=[UIColor lightTextColor];

        }
//    }
//     else
else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"Absent"])
    {
        ccell.infoLbl.text=[NSString stringWithFormat:@"On %@ Your Absent",[selectedDateInfo valueForKey:@"date"]];
       // return 0;
    }else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"Holiday"])
    {
         ccell.infoLbl.text=[NSString stringWithFormat:@"On %@ Company Have Holiday",[selectedDateInfo valueForKey:@"date"]];
        //return 0;
    }else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"WeeklyOff"])
    {
         ccell.infoLbl.text=[NSString stringWithFormat:@"On %@ Company Have WeeklyOff",[selectedDateInfo valueForKey:@"date"]];
        //return 0;
    }
       
       
       
       
     else  if(indexPath.row==1+7){
        ccell.infoLbl.text=[NSString stringWithFormat:@"IN TIME :%@",[selectedDateInfo valueForKey:@"in_time"]];
    }else  if(indexPath.row==2+7){
        ccell.infoLbl.text=[NSString stringWithFormat:@"OUT TIME :%@",[selectedDateInfo valueForKey:@"out_time"]];
    }else  if(indexPath.row==3+7){
        ccell.infoLbl.text=[NSString stringWithFormat:@"DURATION :%@",[selectedDateInfo valueForKey:@"duration"]];
    }else{
        NSMutableArray *puncRecords=[selectedDateInfo valueForKey:@"punch_records"];
        ccell.infoLbl.text=[NSString stringWithFormat:@"%@",[puncRecords objectAtIndex:indexPath.row-3-7-1]];
    }
    
    if(indexPath.row==0||indexPath.row==7){
        ccell.contentView.backgroundColor=[UIColor lightTextColor];
        ccell.infoLbl.textColor=[UIColor blackColor];
    }else{
        ccell.contentView.backgroundColor=[UIColor clearColor];
        ccell.infoLbl.textColor=[UIColor whiteColor];

    }
    return ccell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0||indexPath.row==7){
        return CGSizeMake((collectionView.frame.size.width-2), 30);

    }else
     if(indexPath.row<7){
         return CGSizeMake((collectionView.frame.size.width-12)/2, 30);
     }
     else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"Absent"])
     {
        return CGSizeMake((collectionView.frame.size.width-2), 30);
     }else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"Holiday"])
     {
        return CGSizeMake((collectionView.frame.size.width-2), 30);
     }else if([[selectedDateInfo valueForKey:@"status"] isEqualToString:@"WeeklyOff"])
     {
          return CGSizeMake((collectionView.frame.size.width-2), 30);
         
     }
    
    
     else
    if(indexPath.row<11){
        return CGSizeMake(collectionView.frame.size.width/3.2, 30);
    }else{
         return CGSizeMake((collectionView.frame.size.width-12)/2, 30);
    }
  
}


- (IBAction)showingDAteBtnAction:(id)sender {
   // [self makePostCallForPage:ATTENDANCEMONTHSLUST withParams:@{@"employee_code":[userdic valueForKey:@"employee_code"]} withRequestCode:15];
    
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
        
        for(NSDictionary *dict in AvailableList){
            [Item addObject:[dict valueForKey:@"title"]];
        }
        
        [FTPopOverMenu showForSender:_showingDateBtn
                       withMenuArray:Item
                           doneBlock:^(NSInteger selectedIndex) {
                               
                               NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                               self->SelectedMonthDict = [AvailableList objectAtIndex:selectedIndex];
                               [self->_showingDateBtn setTitle:[SelectedMonthDict valueForKey:@"title"] forState:UIControlStateNormal];
                               //                               [_calanderView scrollToDate:[self.dateFormatterForBtn dateFromString:[SelectedMonthDict valueForKey:@"title"]]];
                               [self->_calanderView selectDate:[self.dateFormatterForBtn dateFromString:[SelectedMonthDict valueForKey:@"title"]] scrollToDate:YES];
                               [self.calanderView deselectDate:[self.dateFormatterForBtn dateFromString:[SelectedMonthDict valueForKey:@"title"]]];
                           } dismissBlock:^{
                               
                               NSLog(@"user canceled. do nothing.");
                               
                               //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                               //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                               
                           }];
    
}


@end
