//
//  LeaveTypeCollectionViewCell.h
//  HRMSystem
//
//  Created by Apple on 23/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeaveTypeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leaveImage;
@property (weak, nonatomic) IBOutlet UILabel *leaveTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *remaingLeaveLbl;
@property (weak, nonatomic) IBOutlet UIView *leaveView;

@end

NS_ASSUME_NONNULL_END
