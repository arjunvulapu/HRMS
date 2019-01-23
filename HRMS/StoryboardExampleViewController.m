//
//  StoryboardExampleViewController.m
//  Chinese-Lunar-Calendar
//
//  Created by Wenchao Ding on 01/29/2015.
//  Copyright (c) 2014 Wenchao Ding. All rights reserved.
//

#import "StoryboardExampleViewController.h"
#import "MCLocalization.h"
#import "Common.h"
#import "Utils.h"
@interface StoryboardExampleViewController()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
{
//    NSMutableArray *datesArr;
     NSString *datesArr;
}
@property (weak  , nonatomic) IBOutlet FSCalendar *calendar;
@property (weak  , nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;

@property (assign, nonatomic) NSInteger      theme;
@property (assign, nonatomic) BOOL           lunar;


@property (strong, nonatomic) NSArray<NSString *> *datesWithEvent;

@property (strong, nonatomic) NSCalendar *gregorianCalendar;

@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

- (IBAction)unwind2StoryboardExample:(UIStoryboardSegue *)segue;

@end

@implementation StoryboardExampleViewController

#pragma mark - Life Cycle

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
        
        self.calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesUpperCase;
        
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

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    [self addbackground:self.backgroundview];
    [self.calendar setBackgroundColor:[UIColor clearColor]];
    [[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
    [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
    [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
    [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = true;
    self.navigationController.navigationBar.layer.cornerRadius=25;
    self.navigationController.navigationBar.clipsToBounds=YES;
        [self setTheme:1];
    self.calendar.layer.cornerRadius=10;
    self.calendar.clipsToBounds=YES;
//    self.datesShouldBeSelected = @[@"2018/08/07",
//                                    @"2018/09/07",
//                                    @"2018/10/07",
//                                    @"2018/11/07",
//                                    @"2018/12/07",
//                                    @"2018/01/27",@"2018/01/22",@"2018/01/30",
//                                    @"2018/02/07"];
    
//    self.datesShouldNotBeSelected = @[@"12-02-2018",@"16-02-2018",@"22-02-2018",@"13-02-2018",@"11-02-2018",@"18-02-2018"];
    //_calendar.allowsMultipleSelection = YES;
    _calendar.allowsMultipleSelection = NO;
  datesArr=@"";
    for(NSString *date in self.datesShouldBeSelected){
//       [self calendar:self.calendar appearance:self.calendar.appearance eventSelectionColorsForDate:date];
        
        //[self.calendar selectDate:[self.dateFormatter1 dateFromString:date]];
            self.dateFormatter1 = [[NSDateFormatter alloc] init];
            [ self.dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
            if([self.dateFormatter1 dateFromString:date]>[self.dateFormatter1 dateFromString:[self.dateFormatter1 stringFromDate:[NSDate date]]]){
                
            
//        [datesArr addObject:date];
        
                datesArr=date;
//        [self calendar:self.calendar didSelectDate:[self.dateFormatter1 dateFromString:date] atMonthPosition:FSCalendarMonthPositionCurrent];
         [self.calendar selectDate:[self.dateFormatter1 dateFromString:date] scrollToDate:NO];
            }
    }
    for (NSString *date in self.datesShouldNotBeSelected) {
         if([self.dateFormatter1 dateFromString:date]>[self.dateFormatter1 dateFromString:[self.dateFormatter1 stringFromDate:[NSDate date]]]){
        [self.calendar deselectDate:[self.dateFormatter1 dateFromString:date]];
         }
    }
  
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if ([[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        self.calendarHeightConstraint.constant = 400;
    }
//    [self.calendar selectDate:[self.dateFormatter1 dateFromString:@"2018/01/19"] scrollToDate:YES];
    
    self.calendar.accessibilityIdentifier = @"calendar";
    
//    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close.png"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
//        // Add a negative spacer on iOS >= 7.0
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                           target:nil action:nil];
//        negativeSpacer.width = -50;
//        self.navItem.leftBarButtonItems = @[negativeSpacer, closeButton];
    
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc]initWithTitle:Localized(@"Done    ") style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [doneBtn setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], NSForegroundColorAttributeName,nil]
                          forState:UIControlStateNormal];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                           target:nil action:nil];
//        negativeSpacer.width =10;
        self.navItem.rightBarButtonItems = @[negativeSpacer,doneBtn];
    } else {
        self.navItem.leftBarButtonItem = doneBtn;
    }
    self.navItem.title = Localized(@"Select Dates");
}
//- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date
//{
//    self.dateFormatter1 = [[NSDateFormatter alloc] init];
//    [ self.dateFormatter1 setDateFormat:@"yyyy/MM/dd"];
//    if([self.datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]){
//        return [UIColor redColor];
//    }
//    return [UIColor blackColor];
//}
- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - FSCalendarDataSource

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    return [self.gregorianCalendar isDateInToday:date] ? @"今天" : nil;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    if (!_lunar) {
        return nil;
    }
//    return [self.lunarFormatter stringFromDate:date];
    return nil;
}
- (void)close {
//     self.completionBlock(datesArr);
    [self.delegate cancelButtonClicked:self];
}
- (void)done {
    self.completionBlock(datesArr);
    [self.delegate cancelButtonClicked:self];
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
    return [NSDate date];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter1 dateFromString:@"2038/05/31"];
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
   // [datesArr addObject:[self.dateFormatter1 stringFromDate:date]];
         datesArr = [self.dateFormatter1 stringFromDate:date];
//    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
//        [calendar setCurrentPage:date animated:YES];
//    }
     }
}
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter1 stringFromDate:date]);
    //[datesArr removeObject:[self.dateFormatter1 stringFromDate:date]];
    datesArr=@"";
}
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[self.dateFormatter1 stringFromDate:calendar.currentPage]);
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
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
    if ([_datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
//        [self calendar:self.calendar appearance:self.calendar.appearance eventSelectionColorsForDate:date];

        return [UIColor lightGrayColor];
        
    }
    return nil;
}
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date;
{
    if ([_datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
        //        [self calendar:self.calendar appearance:self.calendar.appearance eventSelectionColorsForDate:date];
        
        return [UIColor lightGrayColor];
        
    }
    return nil;
}
- (nullable NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date;
{
    if ([_datesShouldNotBeSelected containsObject:[self.dateFormatter1 stringFromDate:date]]) {
        //        [self calendar:self.calendar appearance:self.calendar.appearance eventSelectionColorsForDate:date];
        
        return [UIColor lightGrayColor];
        
    }
    return nil;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    CalendarConfigViewController *config = segue.destinationViewController;
//    config.lunar = self.lunar;
//    config.theme = self.theme;
//    config.selectedDate = self.calendar.selectedDate;
//    config.firstWeekday = self.calendar.firstWeekday;
//    config.scrollDirection = self.calendar.scrollDirection;
}

- (void)unwind2StoryboardExample:(UIStoryboardSegue *)segue
{
//    CalendarConfigViewController *config = segue.sourceViewController;
//    self.lunar = config.lunar;
//    self.theme = config.theme;
//    [self.calendar selectDate:config.selectedDate scrollToDate:NO];
//
//    if (self.calendar.firstWeekday != config.firstWeekday) {
//        self.calendar.firstWeekday = config.firstWeekday;
//    }
//
//    if (self.calendar.scrollDirection != config.scrollDirection) {
//        self.calendar.scrollDirection = config.scrollDirection;
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"FSCalendar" message:[NSString stringWithFormat:@"Now swipe %@",@[@"Vertically", @"Horizontally"][self.calendar.scrollDirection]] preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }

}

#pragma mark - Private properties

- (void)setTheme:(NSInteger)theme
{
    if (_theme != theme) {
        _theme = theme;
        switch (theme) {
            case 0: {
                _calendar.appearance.weekdayTextColor = FSCalendarStandardTitleTextColor;
                _calendar.appearance.headerTitleColor = FSCalendarStandardTitleTextColor;
                _calendar.appearance.eventDefaultColor = FSCalendarStandardEventDotColor;
                _calendar.appearance.selectionColor = FSCalendarStandardSelectionColor;
                _calendar.appearance.headerDateFormat = @"MMMM yyyy";
                _calendar.appearance.todayColor = FSCalendarStandardTodayColor;
                _calendar.appearance.borderRadius = 1.0;
                _calendar.appearance.headerMinimumDissolvedAlpha = 0.2;
                break;
            }
            case 1: {
                _calendar.appearance.weekdayTextColor = FSCalendarStandardTitleTextColor;
                _calendar.appearance.headerTitleColor = FSCalendarStandardTitleTextColor;
                _calendar.appearance.eventDefaultColor = FSCalendarStandardEventDotColor;
                _calendar.appearance.selectionColor = [UIColor blackColor];
                //_calendar.appearance.headerDateFormat = @"yyyy-MM";
                _calendar.appearance.headerDateFormat = @"MMMM yyyy";
                _calendar.appearance.todayColor = FSCalendarStandardTodayColor;
                _calendar.appearance.borderRadius = 1.0;
                _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
                
                break;
            }
            case 2: {
                _calendar.appearance.weekdayTextColor = [UIColor redColor];
                _calendar.appearance.headerTitleColor = [UIColor redColor];
                _calendar.appearance.eventDefaultColor = [UIColor greenColor];
                _calendar.appearance.selectionColor = [UIColor blueColor];
                _calendar.appearance.headerDateFormat = @"yyyy/MM";
                _calendar.appearance.todayColor = [UIColor orangeColor];
                _calendar.appearance.borderRadius = 0;
                _calendar.appearance.headerMinimumDissolvedAlpha = 1.0;
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)setLunar:(BOOL)lunar
{
    if (_lunar != lunar) {
        _lunar = lunar;
        [_calendar reloadData];
    }
}

- (IBAction)close:(id)sender {
   [self.delegate cancelButtonClicked:self];
}
-(void)viewDidDisappear:(BOOL)animated{
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [[UILabel appearance] setTextAlignment:NSTextAlignmentRight];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentRight];
        
        [[UITextView appearance] setTextAlignment:NSTextAlignmentRight];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"Hacen Tunisia Lt" size:17];
        [UITextField appearance].font=[UIFont fontWithName:@"Hacen Tunisia Lt" size:17];
        [UITextView appearance].font=[UIFont fontWithName:@"Hacen Tunisia Lt" size:17];
        
    } else {
        //[[UILabel appearance] setSubstituteFontName:@"Avenir Next Condensed"];
        
        [[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"Sansation-Regular" size:17];
        [UITextField appearance].font=[UIFont fontWithName:@"Sansation-Regular" size:17];
        [UITextView appearance].font=[UIFont fontWithName:@"Sansation-Regular" size:17];
        
    }
}
@end

