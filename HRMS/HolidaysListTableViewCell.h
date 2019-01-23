//
//  HolidaysListTableViewCell.h
//  HRMSystem
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HolidaysListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackGroundView;
@property (weak, nonatomic) IBOutlet UILabel *Reason;
@property (weak, nonatomic) IBOutlet UILabel *DateLbl;

@end

NS_ASSUME_NONNULL_END
