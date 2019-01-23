//
//  AppDelegate.h
//  HRMS
//
//  Created by Apple on 17/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)afterLoginSucess;
- (void)afterLoginLogOut;
@end

