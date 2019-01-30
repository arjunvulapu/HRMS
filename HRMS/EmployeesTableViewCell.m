//
//  EmployeesTableViewCell.m
//  HRMSystem
//
//  Created by Apple on 28/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "EmployeesTableViewCell.h"

@implementation EmployeesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)workSheetBtnAction:(id)sender {
    if(self.openWorkSheet){
        self.openWorkSheet();
    }
}
@end
