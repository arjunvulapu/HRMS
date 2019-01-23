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
#define KEY_LANGUAGE_AR @"ar"


#define LAST_CLOSED_TIME @"LAST_CLOSED_TIME"

#define THEME_COLOR [UIColor colorWithRed:60/255.0f green:60/255.0f blue:60/255.0f alpha:1];
#define BUTTON_BG_COLOR [UIColor whiteColor];
#define PROJECT_GRAY [UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1];

#define PLACEHOLDER_COLOR [UIColor grayColor];

#define Localized(string) [MCLocalization stringForKey:string]

#define APP_DELEGATE (AppDelegate *) [[UIApplication sharedApplication] delegate]


//#define SERVER_URL @"http://products.yellowsoft.in/homeworkers/api/"
#define SERVER_URL @"https://hrm.develappsolutions.com/api/"

#define HOLIDAYSLIST @"holidays.php"
#define EMPLOYEEDETIALS @"employees.php"
#define LOGIN @"login.php"
#define LEAVETYPES @"leave_types.php"
#define APPLYLEAVE @"leave.php"
#define CONTACTUS @"contact.php"
#define ATTENDANCE @"attendance.php"
#define USERLEAVES @"leaves.php"
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#endif
