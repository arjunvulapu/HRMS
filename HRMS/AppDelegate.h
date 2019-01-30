//
//  AppDelegate.h
//  HRMS
//
//  Created by Apple on 17/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import <OneSignal/OneSignal.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong,nonatomic) LocationManager * shareModel;

@property (strong, nonatomic) UIWindow *window;
- (void)afterLoginSucess;
- (void)afterLoginLogOut;
@end

