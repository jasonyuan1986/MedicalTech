//
//  MyCourseViewController.m
//  MedicalTech
//
//  Created by Jason on 8/16/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "MyCourseViewController.h"
#import "MyCourseTableViewCell.h"
#import "MyCourseService.h"
#import "CourseDetailViewController.h"

@interface MyCourseViewController () <UITableViewDelegate, UITableViewDataSource, MyCourseServiceDelegate>
{
    UITableView *myTableView;
    
}

@property (nonatomic, strong) NSArray *myCourseArray;
@property (nonatomic, strong) CourseDetailViewController *courseDetailViewController;

@end

@implementation MyCourseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    MyCourseService *myCourseService = [[MyCourseService alloc] init];
    myCourseService.delegate = self;
    [myCourseService getMyCourse];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的课程";
    
    [self initUI];
    
    
}

- (void)initUI {
    myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView registerClass:[MyCourseTableViewCell class] forCellReuseIdentifier:@"myCourseCell"];
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
    return [self.myCourseArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MyCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCourseCell" forIndexPath:indexPath];
 
     // Configure the cell...
     if (cell == nil) {
         cell = [[MyCourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCourseCell"];
         cell.separatorInset = UIEdgeInsetsZero;
     }
 
     [cell setText:[self.myCourseArray objectAtIndex:indexPath.row]];
     
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
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [self.myCourseArray objectAtIndex:indexPath.row];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    if (self.courseDetailViewController) {
        self.courseDetailViewController.listId = [dictionary objectForKey:@"listId"];
        [self.navigationController pushViewController:self.courseDetailViewController animated:YES];
    } else {
        self.courseDetailViewController = [[CourseDetailViewController alloc] init];
        self.courseDetailViewController.listId = [dictionary objectForKey:@"listId"];
        [self.navigationController pushViewController:self.courseDetailViewController animated:YES];
    }
}

#pragma mark - MyCourseService delegate

- (void)returnMyCourse:(NSArray *)dataArray {
    NSLog(@"%@", dataArray);
    self.myCourseArray = dataArray;
    [myTableView reloadData];
}

@end
