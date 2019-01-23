//
//  LoginViewController.m
//  HRMS
//
//  Created by Apple on 18/01/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    
    [self addbackground:self.backgroundView];
    
    self.emailTxtfield.text=@"";
    self.passwordTxtField.text=@"";
    self.emailTxtfield.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Employee Code")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.passwordTxtField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Password")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.submitBtn.layer.cornerRadius = self.submitBtn.frame.size.height/2;
    self.submitBtn.clipsToBounds = YES;
    self.submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.submitBtn.layer.borderWidth = 2;
    [self.submitBtn setTitle:Localized(@"SUBMIT") forState:UIControlStateNormal];
}
-(void)viewWillAppear:(BOOL)animated{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtnAction:(id)sender {

    if(_emailTxtfield.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter EmployeeCode")];
    }else if(_passwordTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Password")];
    }
    else{
        [self makePostCallForPage:LOGIN withParams:@{@"employee_code":_emailTxtfield.text,@"password":_passwordTxtField.text} withRequestCode:100];
    }
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
   
    if (reqeustCode == 100) {
        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            [Utils loginUserWithMemberId:[result valueForKey:@"member_id"] withType:@"User"];
         
            [APP_DELEGATE afterLoginSucess];
            
        }
    }
}
@end
