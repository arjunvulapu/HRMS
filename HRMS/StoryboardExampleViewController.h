//
//  FSViewController.h
//  Chinese-Lunar-Calendar
//
//  Created by Wenchao Ding on 01/29/2015.
//  Copyright (c) 2017 Wenchao Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "PopViewControllerDelegate.h"
#import "BaseViewController.h"
@interface StoryboardExampleViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic, copy) void (^completionBlock)(NSString *datesList);
- (IBAction)close:(id)sender;
@property (strong, nonatomic) NSMutableArray * _Nullable datesShouldBeSelected;
@property (strong, nonatomic) NSMutableArray * _Nonnull datesShouldNotBeSelected;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;

@end
