//
//  ProjectCell.h
//  HRMSystem
//
//  Created by Apple on 05/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *Ptitle;

@end

NS_ASSUME_NONNULL_END
