//
//  AppliedLeavesTableViewCell.m
//  HRMSystem
//
//  Created by Apple on 22/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AppliedLeavesTableViewCell.h"

@implementation AppliedLeavesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelBtnAction:(id)sender {
    if(self.Cancel){
        self.Cancel();
    }
}
- (IBAction)acceptBtnAction:(id)sender {
    if(self.acceptBtnAction){
        self.acceptBtnAction();
    }
}

- (IBAction)hrCancelledBtnAction:(id)sender {
    if(self.hrCancelBtnAction){
        self.hrCancelBtnAction();
    }
}
@end
