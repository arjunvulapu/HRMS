//
//  SelectAreaViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "SelectAreaViewController.h"
#import "FTPopOverMenu/FTPopOverMenu.h"
@interface SelectAreaViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *projectList;
    NSDictionary *selectedProject;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic) NSMutableArray *areas;

@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbackground:_bgView];
    self.areas = [[NSMutableArray alloc] init];
    self->projectList = [[NSMutableArray alloc] init];

    self.projectNameTxtField.text=@"";
    self.taskTitle.text=@"";
    self.descriptionTxtView.text=@"";
    
    self.projectNameTxtField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Select Project")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.taskTitle.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Enter Title")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    
    self.descriptionTxtView.placeholder= Localized(@"Description");
    self.descriptionTxtView.textColor=[UIColor whiteColor];
    self.addtaskBtn.layer.cornerRadius = self.addtaskBtn.frame.size.height/2;
    self.addtaskBtn.clipsToBounds = YES;
    self.addtaskBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.addtaskBtn setTitle:Localized(@"ADD TASK") forState:UIControlStateNormal];
    
    
    self.navItem.title = Localized(@"Enter Task Detials");
    [self.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if ([self.restId length] > 0) {
        [dictionary setValue:self.restId forKey:@"rest_id"];
    }
    self.areas=_areasList;
    [self makePostCallForPage:PROJECTS
                   withParams:@{@"employee_id":[Utils loggedInUserIdStr]}
              withRequestCode:1];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    projectList=result;
}

- (void)close {
    [self.delegate cancelButtonClicked:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    Country *country = [self.areas objectAtIndex:section];
//    return country.title;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    Country *country = [self.areas objectAtIndex:section];
//    return [country.areas count];
    return self.areas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
//    Country *country = [self.areas objectAtIndex:indexPath.section];
//    CountryArea *cat = [country.areas objectAtIndex:indexPath.row];
    NSMutableDictionary *dic=[self.areas objectAtIndex:indexPath.row];
    if([dic objectForKey:@"title"] != nil){
        if([[Utils getLanguage] isEqual:KEY_LANGUAGE_AR]){
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.areas objectAtIndex:indexPath.row] valueForKey:@"title_ar"]];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.areas objectAtIndex:indexPath.row] valueForKey:@"title"]];

        }
}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Country *country = [self.areas objectAtIndex:indexPath.section];
//    CountryArea *cat = [country.areas objectAtIndex:indexPath.row];
NSMutableDictionary *str=[self.areas objectAtIndex:indexPath.row];
    self.completionBlock(str);
    [self.delegate cancelButtonClicked:self];
}


- (IBAction)close:(id)sender {
    [self.delegate cancelButtonClicked:self];

}
- (IBAction)projectAction:(id)sender {
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 40;
    configuration.menuWidth = 120;
    configuration.textColor = [UIColor blackColor];
    configuration.textFont = [UIFont boldSystemFontOfSize:14];
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor lightGrayColor];
    configuration.borderWidth = 0.5;
    configuration.textAlignment = UITextAlignmentCenter;
    NSMutableArray *Item=[[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in projectList){
        [Item addObject:[dict valueForKey:@"title"]];
    }
    
    [FTPopOverMenu showForSender:_projectBtn
                   withMenuArray:Item
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           self->selectedProject = [self->projectList objectAtIndex:selectedIndex];
                           self->_projectNameTxtField.text=[self->selectedProject valueForKey:@"title"];
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                           //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                           //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
    
}

- (IBAction)addtaskBtnAction:(id)sender {
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    [dic setValue:[selectedProject valueForKey:@"id"] forKey:@"project_id"];
    [dic setValue:[Utils loggedInUserIdStr] forKey:@"employee_id"];
    [dic setValue:[Utils loggedInUserIdStr] forKey:@"assigned_to"];

    [dic setValue:_taskTitle.text forKey:@"title"];
    [dic setValue:_descriptionTxtView.text forKey:@"description"];
    self.completionBlock(dic);
    [self.delegate cancelButtonClicked:self];


    
}
@end
