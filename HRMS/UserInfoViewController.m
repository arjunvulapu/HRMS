//
//  UserInfoViewController.m
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "SWRevealViewController.h"
#import "ListViewController.h"
#import "AttendanceViewController.h"
#import "HolidaysListViewController.h"
#import "ApplyLeaveViewController.h"
#import "HRListViewController.h"
#import "WorkSheetViewController.h"
#import "DailyWorkSheetViewController.h"
#import "EmployeesViewController.h"
#import "NotificationsViewController.h"
#import "ProjectsVC.h"
@interface UserInfoViewController ()<SWRevealViewControllerDelegate>
{
    NSMutableDictionary *UserInfoDict;
    UIButton *rightbutton;

}
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",[APP_DELEGATE fromPushNotification]);
    if([[APP_DELEGATE fromPushNotification] isEqual:@"YES"]){
        NSDictionary *pushDic=[APP_DELEGATE pushDict];
        if([[pushDic valueForKey:@"type"] isEqualToString:@"worksheet"]){
        DailyWorkSheetViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyWorkSheetViewController"];
        NSMutableDictionary *dic=[[NSUserDefaults standardUserDefaults ]valueForKey:@"USER"];

        controller.addedBy=[Utils loggedInUserIdStr];
        controller.whosWorksheet=[pushDic valueForKey:@"type_id"];

        controller.Fname=[dic valueForKey:@"fname"];
        controller.Lname=[dic valueForKey:@"lname"];
        
        [self.navigationController pushViewController:controller animated:YES];
        }
        else if([[pushDic valueForKey:@"type"] isEqualToString:@"general"]){
            NotificationsViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
            
            [self.navigationController pushViewController:controller animated:YES];
        }else if([[pushDic valueForKey:@"type"] isEqualToString:@"leaves"]){
            ListViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
            controller.from=@"holidays";
            [self.navigationController pushViewController:controller animated:YES];
        }else if([[pushDic valueForKey:@"type"] isEqualToString:@"tasks"]){
            WorkSheetViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkSheetViewController"];
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    [self addbackground:self.backgroundView];
    _nameLbl.text=@"";
    _role.text=@"";
    _numberRLBl.text=@"";
    _emailRLbl.text=@"";
    _addressRLbl.text=@"";
    _BackScrollVew.layer.cornerRadius=10;
    _BackScrollVew.clipsToBounds=YES;
    _backView.layer.cornerRadius=15;
    _backView.clipsToBounds=YES;
    self.titleLbl.text=Localized(@"DIGITAL ID");
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 5;
    _addressRLbl.textAlignment=NSTextAlignmentCenter;
    
    [self makePostCallForPage:EMPLOYEEDETIALS withParams:@{@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:12];
    rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftbutton setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    [rightbutton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    rightbutton.tintColor = [UIColor redColor];

    
    rightbutton.frame = CGRectMake(0, 0, 30, 30);
    //[leftbutton addTarget:self action:@selector(showSideMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    UIView *backButtonView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    backButtonView2.bounds = CGRectOffset(backButtonView2.bounds, 0, 0);
    [backButtonView2 addSubview:rightbutton];
    UIBarButtonItem *backButton2 = [[UIBarButtonItem alloc] initWithCustomView:backButtonView2];
    self.navigationItem.leftBarButtonItem = backButton2;
    
    //    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightItem,nil];
    [self customSetup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
   
}
-(void)viewWillAppear:(BOOL)animated{
 self.tabBarController.tabBar.hidden=NO;    
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    //self.navigationController.navigationBar.translucent = NO;
    [self.tabBarController setSelectedIndex:0];
    if ([[notification name] isEqualToString:@"TestNotification"])
    {
        NSDictionary* userInfo = notification.userInfo;
        NSNumber* selectedId = (NSNumber*)userInfo[@"selectedId"];
        NSNumber* sectionId = (NSNumber*)userInfo[@"sectionId"];
        
       
        [self.revealViewController revealToggleAnimated:YES];
        NSMutableDictionary *dic=[[NSUserDefaults standardUserDefaults ]valueForKey:@"USER"];
        int forhr=0;
        if([[dic valueForKey:@"hr"] isEqualToString:@"1"])
        {
            forhr=1;
        }
            
            
            if([selectedId isEqual:@0]){
//                ContactUsViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
//                [self.navigationController pushViewController:controller animated:YES];
                
            }else if([selectedId isEqual:@1]){
                self.tabBarController.tabBar.hidden=YES;
                NotificationsViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
                
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if([selectedId isEqual:@3]){
                self.tabBarController.tabBar.hidden=YES;
                EmployeesViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeesViewController"];
                
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if([selectedId isEqual:@2]){
                self.tabBarController.tabBar.hidden=YES;
                ProjectsVC  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectsVC"];
                
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if([selectedId isEqual:@4]){
                self.tabBarController.tabBar.hidden=YES;
                WorkSheetViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkSheetViewController"];
               
                [self.navigationController pushViewController:controller animated:YES];
                
            }
        
            else if([selectedId isEqual:@5]){
                self.tabBarController.tabBar.hidden=YES;
                DailyWorkSheetViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyWorkSheetViewController"];
                controller.addedBy=[Utils loggedInUserIdStr];
                controller.whosWorksheet=[Utils loggedInUserIdStr];
                controller.Fname=[dic valueForKey:@"fname"];
                controller.Lname=[dic valueForKey:@"lname"];

                [self.navigationController pushViewController:controller animated:YES];
              
            }
            else if([selectedId isEqual:@6]){
                self.tabBarController.tabBar.hidden=YES;
                ListViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
                controller.from=@"holidays";
                [self.navigationController pushViewController:controller animated:YES];
                
            }
           else if([selectedId isEqual:@7]&&[[dic valueForKey:@"hr"] isEqualToString:@"1"]){
                self.tabBarController.tabBar.hidden=YES;
                HRListViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"HRListViewController"];
                
                [self.navigationController pushViewController:controller animated:YES];
                
           } else if([selectedId isEqual:@(7+forhr)]){
               self.tabBarController.tabBar.hidden=YES;
               AttendanceViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceViewController"];
               
               [self.navigationController pushViewController:controller animated:YES];
               
           }
            else if([selectedId isEqual:@(8+forhr)]){
                //[self.tabBarController setSelectedIndex:1];
                HolidaysListViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"HolidaysListViewController"];
                
                [self.navigationController pushViewController:controller animated:YES];
            }
            else if([selectedId isEqual:@(9+forhr)]){
                //[self.tabBarController setSelectedIndex:2];
                ApplyLeaveViewController  *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ApplyLeaveViewController"];
                
                [self.navigationController pushViewController:controller animated:YES];
            }else if([selectedId isEqual:@(10+forhr)]){
                [Utils logoutUser];
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                [defaults setObject:nil forKey:@"USER"];
                [defaults synchronize];
                //NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                [defaults setObject:UserInfoDict forKey:@"USER"];
                
                NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
                NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
                [self makePostCallForPage:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"employee_id":[Utils loggedInUserIdStr]} withRequestCode:100];
                [APP_DELEGATE afterLoginLogOut];
            }
        
    }
}
- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        //        UITapGestureRecognizer *tap = [revealViewController tapGestureRecognizer];
        //        tap.delegate = self;
        //
        //        [self.view addGestureRecognizer:tap];
        
        [rightbutton  addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside] ;
        //        [self.revealButtonItem setTarget: self.revealViewController];
        //        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==12){
        if(result[0]){
        UserInfoDict = result[0];
        NSString *fullStr=[NSString stringWithFormat:@"%@ %@(%@)",[UserInfoDict valueForKey:@"fname"],[UserInfoDict valueForKey:@"lname"],[UserInfoDict valueForKey:@"employee_code"]];
        NSString *nameStr=[NSString stringWithFormat:@"%@ %@",[UserInfoDict valueForKey:@"fname"],[UserInfoDict valueForKey:@"lname"]];
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullStr];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(nameStr.length,fullStr.length-nameStr.length)];
       
        [self.nameLbl setAttributedText:string];
        
//        _nameLbl.text=[NSString stringWithFormat:@"%@ %@(%@)",[UserInfoDict valueForKey:@"fname"],[UserInfoDict valueForKey:@"lname"],[UserInfoDict valueForKey:@"employee_code"]];
        _nameLbl.textAlignment=NSTextAlignmentCenter;
        _role.text=[NSString stringWithFormat:@"%@",[UserInfoDict valueForKey:@"designation"]];
        _numberRLBl.text=[NSString stringWithFormat:@"%@",[UserInfoDict valueForKey:@"phone"]];
        _emailRLbl.text=[NSString stringWithFormat:@"%@",[UserInfoDict valueForKey:@"company_email"]];
        _addressRLbl.text=[NSString stringWithFormat:@"%@",[UserInfoDict valueForKey:@"address"]];
//        [_userImage setImageWithURL:[UserInfoDict valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_imageView setImageWithURL:[UserInfoDict valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_userImage setHidden:YES];

        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:UserInfoDict forKey:@"USER"];
        
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
        NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
        [self makePostCallForPage:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"employee_id":[Utils loggedInUserIdStr],@"device_type":@"0"} withRequestCode:100];
    
    }else{
        [APP_DELEGATE afterLoginLogOut];
    }
    }
        else if(reqeustCode==100){
        NSLog(@"token registerd");
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
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    NSString* strDeviceToken = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"Device_Token     -----> %@\n", strDeviceToken);
    [[NSUserDefaults standardUserDefaults] setValue:strDeviceToken forKey:@"TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
