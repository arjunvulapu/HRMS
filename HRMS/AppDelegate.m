//
//  AppDelegate.m
//  HRMS
//
//  Created by Apple on 17/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "Utils.h"
#import "Common.h"
#import "IQKeyboardManager.h"
#import "MainViewController.h"
@interface UIFont (SystemFontOverride)
@end
@implementation UIFont (SystemFontOverride)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        return [UIFont fontWithName:@"Oswald-Light" size:fontSize];
    }else{
        return [UIFont fontWithName:@"Oswald-Light" size:fontSize];
    }
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        return [UIFont fontWithName:@"Oswald-Light" size:fontSize];
    }else{
        return [UIFont fontWithName:@"Oswald-Light" size:fontSize];
    }
}

#pragma clang diagnostic pop

@end

//@implementation UILabel (Helper)
//- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
//    // NSLog(@"%@",name);
//    self.font = [UIFont fontWithName:name size:self.font.pointSize];
//
//}
//@end
//@implementation UITextView (Helper)
//- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
//    // NSLog(@"%@",name);
//    self.font = [UIFont fontWithName:name size:self.font.pointSize];
//
//}
//@end


@implementation UILabel (Helper)

- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    // NSLog(@"%@",name);
    //NSLog(@"%@-%@",self.font.fontName,self.font.fontDescriptor.fontAttributes);
    if(isBold(self.font.fontDescriptor)){
      //  NSString *str =[NSString stringWithFormat:@"%@-Bold",name];
        self.font = [UIFont fontWithName:@"Oswald-Regular" size:self.font.pointSize];
        
    }else{
        self.font = [UIFont fontWithName:@"Oswald-Light" size:self.font.pointSize];
    }
    
}
BOOL isBold(UIFontDescriptor * fontDescriptor)
{
    return (fontDescriptor.symbolicTraits & UIFontDescriptorTraitBold) != 0;
}

@end
@implementation UITextView (Helper)
- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    // NSLog(@"%@",name);
    self.font = [UIFont fontWithName:name size:self.font.pointSize];
    
}
@end
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:@"57b79a6c-3590-400a-b8ad-2eb00e8300cf"
            handleNotificationAction:nil
                            settings:@{kOSSettingsKeyAutoPrompt: @false}];
    OneSignal.inFocusDisplayType = OSNotificationDisplayTypeNotification;
    
    // Recommend moving the below line to prompt for push after informing the user about
    //   how your app will use them.
    [OneSignal promptForPushNotificationsWithUserResponse:^(BOOL accepted) {
        NSLog(@"User accepted notifications: %d", accepted);
    }];
    
    
    // Override point for customization after application launch.
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [[UINavigationBar appearance] setBarTintColor: [UIColor whiteColor]];
//    [[UINavigationBar appearance] setTranslucent:false];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:90/255.0f green:35/255.0f  blue:112/255.0f  alpha:1.0]];
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [[UITextView appearance] setTextContainerInset:UIEdgeInsetsZero];
//    [UITextView appearance].textContainer.lineFragmentPadding = 0;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; // This is for clear navigation bar
    [[UINavigationBar appearance] setShadowImage:[UIImage new]]; // this for remvove line under the navigationbar
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];

    
//    for(NSString *fontfamilyname in [UIFont familyNames])
//        {
//            NSLog(@"family:'%@'",fontfamilyname);
//            for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//            {
//                NSLog(@"\tfont:'%@'",fontName);
//            }
//            NSLog(@"-------------");
//        }
    [[UITextField appearance] setTextColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName:[UIFont fontWithName:@"Oswald-Light" size:12.0f]
                                                        } forState:UIControlStateNormal];
    // Override point for customization after application launch.
        //[[UILabel appearance] setSubstituteFontName:@"Avenir Next Condensed"];
        [[UILabel appearance] setSubstituteFontName:@"Oswald-Light"];
        [[UITextView appearance] setSubstituteFontName:@"Oswald-Light"];
        
        [[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"Oswald-Light" size:17];
        [UITextField appearance].font=[UIFont fontWithName:@"Oswald-Light" size:15];
        [UITextView appearance].font=[UIFont fontWithName:@"Oswald-Light" size:15];
        
        
    
//    NSArray *fonts = [UIFont fontNamesForFamilyName:@"Bebas Neue"];
//
//    for(NSString *string in fonts){
//        NSLog(@"%@", string);
//    }
    if([Utils loggedInUserId] != -1){
        [self afterLoginSucess];
    }else{
        [self afterLoginLogOut];
    }
    
    
    // for location
    self.shareModel = [LocationManager sharedManager];
    self.shareModel.afterResume = NO;
    [self.shareModel addApplicationStatusToPList:@"didFinishLaunchingWithOptions"];
    [self.shareModel startMonitoringLocation];
    UIAlertView * alert;
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied) {
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted) {
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        
        // When there is a significant changes of the location,
        // The key UIApplicationLaunchOptionsLocationKey will be returned from didFinishLaunchingWithOptions
        // When the app is receiving the key, it must reinitiate the locationManager and get
        // the latest location updates
        
        // This UIApplicationLaunchOptionsLocationKey key enables the location update even when
        // the app has been killed/terminated (Not in th background) by iOS or the user.
        
        NSLog(@"UIApplicationLaunchOptionsLocationKey : %@" , [launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]);
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            
            // This "afterResume" flag is just to show that he receiving location updates
            // are actually from the key "UIApplicationLaunchOptionsLocationKey"
            self.shareModel.afterResume = YES;
            
            [self.shareModel startMonitoringLocation];
            [self.shareModel addResumeLocationToPList];
        }
    }
    
    [OneSignal addSubscriptionObserver:self];
    return YES;
}

- (void)onOSPermissionChanged:(OSPermissionStateChanges*)stateChanges {
    
    // Example of detecting anwsering the permission prompt
    if (stateChanges.from.status == OSNotificationPermissionNotDetermined) {
        if (stateChanges.to.status == OSNotificationPermissionAuthorized)
            NSLog(@"Thanks for accepting notifications!");
        else if (stateChanges.to.status == OSNotificationPermissionDenied)
            NSLog(@"Notifications not accepted. You can turn them on later under your iOS settings.");
    }
    
    // prints out all properties
    NSLog(@"PermissionStateChanges:\n%@", stateChanges);
}
- (void)onOSSubscriptionChanged:(OSSubscriptionStateChanges*)stateChanges {
    
    // Example of detecting subscribing to OneSignal
    if (!stateChanges.from.subscribed && stateChanges.to.subscribed) {
        NSLog(@"Subscribed for OneSignal push notifications!");
        // get player ID
        
        NSLog(@"player_id     -----> %@\n", stateChanges.to.userId);
        NSLog(@"player_id     -----> %@\n", stateChanges.to.pushToken);

        [[NSUserDefaults standardUserDefaults] setValue:stateChanges.to.userId forKey:@"player_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // prints out all properties
    NSLog(@"SubscriptionStateChanges:\n%@", stateChanges);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
   

//- (void)applicationWillResignActive:(UIApplication *)application {
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//}
//
//
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//}
//
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//}
//
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}
//
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//}

- (void)afterLoginSucess {
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    
}
- (void)afterLoginLogOut {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
    [self.shareModel restartMonitoringLocation];
    
    [self.shareModel addApplicationStatusToPList:@"applicationDidEnterBackground"];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    
    [self.shareModel addApplicationStatusToPList:@"applicationDidBecomeActive"];
    
    //Remove the "afterResume" Flag after the app is active again.
    self.shareModel.afterResume = NO;
    
    [self.shareModel startMonitoringLocation];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    [self.shareModel addApplicationStatusToPList:@"applicationWillTerminate"];
}
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
