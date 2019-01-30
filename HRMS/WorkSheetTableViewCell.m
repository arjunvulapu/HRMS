//
//  WorkSheetTableViewCell.m
//  HRMSystem
//
//  Created by Apple on 26/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "WorkSheetTableViewCell.h"

@implementation WorkSheetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)statusBtnAction:(id)sender {
    if(self.chageStatus)
    {
        self.chageStatus();
    }
}
@end
