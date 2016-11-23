//
//  StudyPlanViewController.m
//  MedicalTech
//
//  Created by Jason on 9/6/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "StudyPlanViewController.h"
#import "StudyService.h"
#import "StudyPlanTableViewCell.h"

@interface StudyPlanViewController () <UITableViewDelegate, UITableViewDataSource, StudyServiceDelegate>
{
    UITableView *myTableView;
}

@property (nonatomic, strong) NSArray *myStudyPlanArray;

@end

@implementation StudyPlanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    StudyService *studyService = [[StudyService alloc] init];
    studyService.delegate = self;
    [studyService getStudyPlan];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"学习计划";
    
    [self initUI];
}

- (void)initUI {
    myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView registerClass:[StudyPlanTableViewCell class] forCellReuseIdentifier:@"studyPlanCell"];
    [self.view addSubview:myTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myStudyPlanArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudyPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studyPlanCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[StudyPlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"studyPlanCell"];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    [cell setText:[self.myStudyPlanArray objectAtIndex:indexPath.row]];
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - UI table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - StudyService delegate

- (void)returnStudyPlan:(NSArray *)dataArray {
    NSLog(@"%@", dataArray);
    self.myStudyPlanArray = dataArray;
    [myTableView reloadData];
}

@end
