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
        return [UIFont fontWithName:@"BebasNeueBook" size:fontSize];
    }else{
        return [UIFont fontWithName:@"BebasNeueBook" size:fontSize];
    }
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        return [UIFont fontWithName:@"BebasNeueBook" size:fontSize];
    }else{
        return [UIFont fontWithName:@"BebasNeueBook" size:fontSize];
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
        self.font = [UIFont fontWithName:@"BebasNeueBold" size:self.font.pointSize];
        
    }else{
        self.font = [UIFont fontWithName:@"BebasNeueBook" size:self.font.pointSize];
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

    
    for(NSString *fontfamilyname in [UIFont familyNames])
        {
            NSLog(@"family:'%@'",fontfamilyname);
            for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
            {
                NSLog(@"\tfont:'%@'",fontName);
            }
            NSLog(@"-------------");
        }
    [[UITextField appearance] setTextColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName:[UIFont fontWithName:@"BebasNeueBook" size:12.0f]
                                                        } forState:UIControlStateNormal];
    // Override point for customization after application launch.
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [[UILabel appearance] setSubstituteFontName:@"BebasNeueBook"];
        [[UITextView appearance] setSubstituteFontName:@"BebasNeueBook"];
        
        [[UILabel appearance] setTextAlignment:NSTextAlignmentRight];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentRight];
        
        [[UITextView appearance] setTextAlignment:NSTextAlignmentRight];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"BebasNeueBook" size:17];
        [UITextField appearance].font=[UIFont fontWithName:@"BebasNeueBook" size:17];
        [UITextView appearance].font=[UIFont fontWithName:@"BebasNeueBook" size:17];
        
    } else {
        //[[UILabel appearance] setSubstituteFontName:@"Avenir Next Condensed"];
        [[UILabel appearance] setSubstituteFontName:@"BebasNeueBook"];
        [[UITextView appearance] setSubstituteFontName:@"BebasNeueBook"];
        
        [[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        [[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"BebasNeueBook" size:17];
        [UITextField appearance].font=[UIFont fontWithName:@"BebasNeueBook" size:17];
        [UITextView appearance].font=[UIFont fontWithName:@"BebasNeueBook" size:17];
        
        
    }
    NSArray *fonts = [UIFont fontNamesForFamilyName:@"Bebas Neue"];
    
    for(NSString *string in fonts){
        NSLog(@"%@", string);
    }
    if([Utils loggedInUserId] != -1){
        [self afterLoginSucess];
    }
    return YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
   

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

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
@end
