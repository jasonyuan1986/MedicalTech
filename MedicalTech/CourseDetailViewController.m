//
//  CourseDetailViewController.m
//  MedicalTech
//
//  Created by Jason on 8/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseDetailTableViewCell.h"
#import "MyCourseService.h"
#import "PlayerViewController.h"

@interface CourseDetailViewController () <UITableViewDelegate, UITableViewDataSource, MyCourseServiceDelegate>
{
    UITableView *myTableView;
}

@property (nonatomic, strong) NSArray *courseDetailArray;
@property (nonatomic, strong) PlayerViewController *playerViewController;

@end

@implementation CourseDetailViewController

@synthesize listId;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    MyCourseService *myCourseService = [[MyCourseService alloc] init];
    myCourseService.delegate = self;
    [myCourseService getCourseDetail:self.listId pageNo:1 pageSize:10];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"课件列表";
    
    [self initUI];
}

- (void)initUI {
    myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView registerClass:[CourseDetailTableViewCell class] forCellReuseIdentifier:@"courseDetailCell"];
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
    return [self.courseDetailArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseDetailCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[CourseDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"courseDetailCell"];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    [cell setText:[self.courseDetailArray objectAtIndex:indexPath.row]];
    
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
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [self.courseDetailArray objectAtIndex:indexPath.row];
    
    if (self.playerViewController) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        self.playerViewController.exam_id = [dictionary objectForKey:@"exam_id"];
        self.playerViewController.subject_id = [dictionary objectForKey:@"subject_id"];
        [self.navigationController pushViewController:self.playerViewController animated:YES];
    } else {
        self.playerViewController = [[PlayerViewController alloc] init];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        self.playerViewController.exam_id = [dictionary objectForKey:@"exam_id"];
        self.playerViewController.subject_id = [dictionary objectForKey:@"subject_id"];
        [self.navigationController pushViewController:self.playerViewController animated:YES];
    }
}

#pragma mark - MyCourseService delegate

- (void)returnCourseDetail:(NSArray *)dataArray {
    self.courseDetailArray = dataArray;
    [myTableView reloadData];
}

@end
