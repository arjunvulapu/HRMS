//
//  UIView+RoundedCorners.h
//  HRMSystem
//
//  Created by Apple on 05/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RoundedCorners)
-(void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
