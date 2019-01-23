//
//  AttendanceViewController.h
//  HRMSystem
//
//  Created by Apple on 22/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FSCalendar/FSCalendar.h"
NS_ASSUME_NONNULL_BEGIN

@interface AttendanceViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet FSCalendar *calanderView;
@property (weak, nonatomic) IBOutlet UICollectionView *attendanceCollectionView;

@end

NS_ASSUME_NONNULL_END
