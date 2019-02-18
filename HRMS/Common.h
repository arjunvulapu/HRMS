//
//  Common.h
//  Cavaratmall
//
//  Created by Amit Kulkarni on 12/07/15.
//  Copyright (c) 2015 iMagicsoftware. All rights reserved.
//

#ifndef Cavaratmall_Common_h
#define Cavaratmall_Common_h

#import "AppDelegate.h"

#define KEY_LANGUAGE_EN @"en"
//#define KEY_LANGUAGE_AR @"ar"


#define LAST_CLOSED_TIME @"LAST_CLOSED_TIME"

#define THEME_COLOR [UIColor colorWithRed:60/255.0f green:60/255.0f blue:60/255.0f alpha:1];
#define BUTTON_BG_COLOR [UIColor whiteColor];
#define PROJECT_GRAY [UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1];

#define PLACEHOLDER_COLOR [UIColor grayColor];

#define Localized(string) [MCLocalization stringForKey:string]

#define APP_DELEGATE (AppDelegate *) [[UIApplication sharedApplication] delegate]


//#define SERVER_URL @"http://products.yellowsoft.in/homeworkers/api/"
#define SERVER_URL @"https://hrm.develappsolutions.com/api/"
//#define SERVER_URL @"http://yemnaak.com/api"
#define WORDS @"words-json.php"
#define SETTINGS @"settings.php"

#define HOLIDAYSLIST @"holidays.php"
#define EMPLOYEEDETIALS @"employees.php"
#define LOGIN @"login.php"
#define LEAVETYPES @"leave_types.php"
#define APPLYLEAVE @"leave.php"
#define CONTACTUS @"contact.php"
#define ATTENDANCE @"attendance.php"
#define ATTENDANCEMONTHSLUST @"attendance_avail.php"
#define USERLEAVES @"leaves.php"
#define HRLEAVES @"leaves_hr.php"
#define EMPLOYEELOCATIOn @"employee_location.php"
#define LEAVECANCEL @"leave_cancel.php"
#define HRLEAVEACTION @"leave_approve.php"
#define PAGE_REGISTER_TOKEN @"token-register.php"
#define PROJECTS @"projects.php"
#define PROJECTSLIST @"projects_list.php"

#define ADDTASK @"task.php"
#define TASKLIST @"tasks.php"
#define TASKAPPROVE @"task_approve.php"
#define ADDTOWORKSHEET @"worksheet.php"
#define WORKSHEETLIST @"worksheetss.php"
#define NOTIFICATIONS @"notifications.php"
#define WORKSHEET_MESSAGE_DELETE @"worksheet_delete.php"
#define UICOLOR_FROM_HEX_ALPHA(RGBValue, Alpha) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:Alpha]
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif
