//
//  ContactUsViewController.m
//  Saravana
//
//  Created by apple on 28/09/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Contact Us";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    [self addbackground:self.backGroundview];
    
    
    
    self.nameTxtField.text=@"";
    self.mobileNumberTxtField.text=@"";
    self.emailAddressTxtField.text=@"";
    self.remarksTxtView.text=@"";
    
    self.nameTxtField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Name")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.mobileNumberTxtField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Password")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.emailAddressTxtField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Employee Code")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.remarksTxtView.placeholder= Localized(@"Comment");
    self.remarksTxtView.textColor=[UIColor whiteColor];
    self.submitBtn.layer.cornerRadius = self.submitBtn.frame.size.height/2;
    self.submitBtn.clipsToBounds = YES;
    self.submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.submitBtn.layer.borderWidth = 2;
    [self.submitBtn setTitle:Localized(@"SUBMIT") forState:UIControlStateNormal];
}

- (IBAction)submitBtnAction:(id)sender {
    
    if(_nameTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Enter Name"];
    }else if(_mobileNumberTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Enter MobileNumber"];
    }else if(_emailAddressTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Enter EmailAddress"];
    }else if(_remarksTxtView.text.length==0){
        [self showErrorAlertWithMessage:@"Please Enter Message"];
    }else{
        [self makePostCallForPage:CONTACTUS withParams:@{@"name":_nameTxtField.text,@"phone":_mobileNumberTxtField.text,@"email":_emailAddressTxtField.text,@"message":_remarksTxtView.text} withRequestCode:100];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==100){
        if ([[result valueForKey:@"status"] isEqualToString:@"Failed"]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Requested Sucessfully" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [self popVC];
                                                                  }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
    }
}

@end
