//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "SideMViewController.h"
#import "SWRevealViewController.h"
//#import "ViewController.h"
//#import "GoldPriceViewController.h"
#import "MenuTableViewCell.h"
//#import "SilverPriceViewController.h"
//#import "OilPriceViewController.h"
//#import "NewsCalanderViewController.h"
//#import "XCDYouTubeVideoPlayerViewController.h"
//#import "LocationsViewController.h"
//#import "TabBarController.h"
#import "Common.h"
#import "AppDelegate.h"
#import "Utils.h"
@implementation SWUITableViewCell
@end

@implementation SideMViewController
{
    NSMutableArray *menuItems;
    NSMutableArray *menuItemImages;
    NSMutableArray *menuItems2;
    NSMutableArray *menuItemImages2;
    NSMutableArray *companiesList;

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent =YES;
    
    companiesList=@[Localized(@"MY DETAILS"),Localized(@"CONTACT")];
//    menuItems = @[Localized(@"MY SALES"),Localized(@"MY COMMISSIONS"),Localized(@"ACCOUNT"),Localized(@"LOGOUT")];
    menuItems = @[Localized(@"MY DETAILS"),Localized(@"MY LEAVES"),Localized(@" MY ATTENDANCE"),Localized(@"HOLIDAYS"),Localized(@"APPLY LEAVE"),Localized(@"LOGOUT")];

    menuItemImages = @[@"my-orders.png",@"wishlist-black.png", @"my-addresses.png", ];
    menuItems2 = @[Localized(@"CHAIRMAN & MD"),Localized(@"ABOUT US"), Localized(@"CONTACT US")];
    menuItemImages2 = @[@"customer-care.png",@"contact-us.png", @"about-us.png"];
    [_loginBtn setTitle:Localized(@"LOGIN") forState:UIControlStateNormal];
    [_signUpBtn setTitle:Localized(@"SIGNUP") forState:UIControlStateNormal];
//    [_loginBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
//    [_signUpBtn setTitle:@"SIGNUP" forState:UIControlStateNormal];
    if([Utils loggedInUserId] != -1){
        _LOGINVIEW.hidden=YES;
        _accountView.backgroundColor=[UIColor lightTextColor];
        NSMutableDictionary *dic=[[NSUserDefaults standardUserDefaults ]valueForKey:@"USER"];
        _nameLbl.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"fname"],[dic valueForKey:@"lname"]];
        _emailLbl.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"email"]];
//        _phoneLbl.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"phone"]];
    }else{
        _LOGINVIEW.hidden=NO;
    }
    [_menuTable reloadData];
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self addbackground:self.backGroundView];
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        self.tableviewLeading.constant=75;
//        _leadingEdge.constant=20;
//        _btnTailing.constant=33;
//        _signupTailing.constant=40;
//    }else{
//      self.tableviewLeading.constant=75;
//        _leadingEdge.constant=45;
//        _btnTailing.constant=8;
//
//    }
    _topbutton.layer.borderColor=CFBridgingRetain([UIColor blackColor]);
    _topbutton.layer.borderWidth=2;
    SWRevealViewController *revealController = [self revealViewController];
    [revealController tapGestureRecognizer];
//    menuList = @[@"HOME", @"WISH LIST", @"SHOPPING CART",@"CHECKOUT",@"MY ACCOUNT",@"REGISTER",@"LOGIN"];
//    companiesList=@[Localized(@"MY DETAILS"),Localized(@"HELP AND SUPPORT")];
//    menuItems = @[Localized(@"My Orders"),Localized(@"Wish List"), Localized(@"Saved Addresses")];
//    menuItemImages = @[@"my-orders.png",@"wishlist-black.png", @"my-addresses.png", ];
//    menuItems2 = @[Localized(@"Customer Care"),Localized(@"Contact Us"), Localized(@"About Us")];
//    menuItemImages2 = @[@"customer-care.png",@"contact-us.png", @"about-us.png"];
    [_loginBtn setTitle:Localized(@"LOGIN") forState:UIControlStateNormal];
    [_signUpBtn setTitle:Localized(@"SIGNUP") forState:UIControlStateNormal];
}

//- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
//{
//    // configure the destination view controller:
//    if ( [sender isKindOfClass:[UITableViewCell class]] )
//    {
//        UILabel* c = [(SWUITableViewCell *)sender label];
//        UINavigationController *navController = segue.destinationViewController;
//        ProductsViewController* cvc = [navController childViewControllers].firstObject;
//        if ( [cvc isKindOfClass:[ProductsViewController class]] )
//        {
////            cvc.color = c.textColor;
////            cvc.text = c.text;
//        }
//    }
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([Utils loggedInUserId] != -1){
//    return 2;
         return 1;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if([Utils loggedInUserId] != -1){
    if(section==0){
    return menuItems.count;
    }else{
        return menuItems2.count;

    }
     }else{
         return menuItems2.count;

     }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, 30, 60)];
//    headerView.backgroundColor = [UIColor clearColor];
//
//    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(25,0, self.view.frame.size.width, 50)];
//    label.backgroundColor = [UIColor clearColor];
//    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//    if(section==0){
//    label.text=@"MY DETAILS";
//    }else{
//        label.text=@"HELP AND SUPPORT";
//    }
//    label.font=[UIFont boldSystemFontOfSize:20];
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.borderColor = [UIColor blackColor].CGColor;
//    bottomBorder.borderWidth = 2;
//    bottomBorder.frame = CGRectMake(0, CGRectGetHeight(label.frame)-2, CGRectGetWidth(label.frame), 2);
//    label.clipsToBounds = YES;
//    [label.layer addSublayer:bottomBorder];
//    [headerView addSubview:label];
//    return headerView;
//}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{

        // Background color
        // view.tintColor = [UIColor blackColor];
        
        // Text Color
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
        // [header.textLabel setTextColor:[UIColor whiteColor]];
    if([Utils loggedInUserId] != -1){

        if(companiesList.count>0){
            [header.textLabel setText:[companiesList objectAtIndex:section]];
        }
    }else{
        [header.textLabel setText:[companiesList objectAtIndex:1]];

    }
        // Another way to set the background color
        // Note: does not preserve gradient effect of original header
        // header.contentView.backgroundColor = [UIColor blackColor];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuTableViewCell";

//    switch ( indexPath.row )
//    {
//        case 0:
//            CellIdentifier = @"map";
//            break;
//            
//        case 1:
//            CellIdentifier = @"blue";
//            break;
//
//        case 2:
//            CellIdentifier = @"red";
//            break;
//    }

    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MenuTableViewCell" forIndexPath: indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.namLbl.textColor = [UIColor blackColor];
    //    CALayer *separator = [CALayer layer];
    //    separator.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.25].CGColor;
    //    separator.frame = CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, .5);
    //    [cell.layer addSublayer:separator];
    if([Utils loggedInUserId] != -1){

    if(indexPath.section==0){
    cell.namLbl.text = menuItems[indexPath.row];
    //cell.imgview.image = [UIImage imageNamed:menuItemImages[indexPath.row]];
    }else{
        cell.namLbl.text = menuItems2[indexPath.row];
       // cell.imgview.image = [UIImage imageNamed:menuItemImages2[indexPath.row]];
    }
    }else{
        cell.namLbl.text = menuItems2[indexPath.row];
        //cell.imgview.image = [UIImage imageNamed:menuItemImages2[indexPath.row]];
    }
    cell.namLbl.textColor=[UIColor whiteColor];
    return cell;
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary* userInfo = @{@"selectedId": @(indexPath.row),@"sectionId":@(indexPath.section)};
    
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"TestNotification" object:self userInfo:userInfo];
}
- (IBAction)settingBtnAction:(id)sender {
    NSDictionary* userInfo = @{@"selectedId": @(0),@"sectionId":@(4)};
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"TestNotification" object:self userInfo:userInfo];
}
- (IBAction)fbBtnAction:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/ta7weel"]];
        NSURL *url = [NSURL URLWithString:@"fb://profile/ta7weel"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/ta7weel"]];
    }
    
}

- (IBAction)twitterBtnAction:(id)sender {
    NSURL *twitterURL = [NSURL URLWithString:@"twitter://user?screen_name=ta7weelapp"];
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL])
        [[UIApplication sharedApplication] openURL:twitterURL];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/ta7weelapp"]];
    
}

- (IBAction)instagramBtnAction:(id)sender {
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=ta7weel"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
}

- (IBAction)signupBtnAction:(id)sender {
    NSDictionary* userInfo = @{@"selectedId": @(2),@"sectionId":@(2)};
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"TestNotification" object:self userInfo:userInfo];
}

- (IBAction)loginBtnAction:(id)sender {
    NSDictionary* userInfo = @{@"selectedId": @(3),@"sectionId":@(3)};
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"TestNotification" object:self userInfo:userInfo];
}
- (IBAction)toCompany:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://develappsolutions.com"]];

}
@end
