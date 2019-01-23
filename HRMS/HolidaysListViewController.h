//
//  HolidaysListViewController.h
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HolidaysListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *holidaysTableView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet NSString *from;

@end

NS_ASSUME_NONNULL_END
