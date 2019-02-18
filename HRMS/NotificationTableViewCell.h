//
//  NotificationTableViewCell.h
//  HRMSystem
//
//  Created by Apple on 04/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nTitle;
@property (weak, nonatomic) IBOutlet UITextView *nMsg;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END
