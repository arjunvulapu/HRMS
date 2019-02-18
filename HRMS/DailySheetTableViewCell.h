//
//  DailySheetTableViewCell.h
//  HRMSystem
//
//  Created by Apple on 28/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DailySheetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBgView;
@property (weak, nonatomic) IBOutlet UITextView *taskTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UILabel *addedName;
@property (weak, nonatomic) IBOutlet UIImageView *addedImage;
@property (weak, nonatomic) IBOutlet UITextView *commentForMsgTxtView;

@property (weak, nonatomic) IBOutlet UIView *dateCellbackgroundview;
@end

NS_ASSUME_NONNULL_END
