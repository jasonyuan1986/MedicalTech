//
//  InboxViewController.m
//  MedicalTech
//
//  Created by Jason on 8/23/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "InboxViewController.h"
#import "HMSegmentedControl.h"
#import "MessageTableViewCell.h"
#import "InboxService.h"

@interface InboxViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, InboxServiceDelegate>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UITableView *messageTableView;
@property (nonatomic, strong) NSArray *messageArray;

@end

@implementation InboxViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    InboxService *inboxService = [[InboxService alloc] init];
    inboxService.delegate = self;
    [inboxService getMyMessage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收件箱";
    
    [self initUI];
}

- (void)initUI {
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"我的消息", @"软件公告"]];
    
    self.segmentedControl.frame = CGRectMake(0, 64, SCREEN_WIDTH, 41);
    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:30.0/255.0 green:198.0/255.0 blue:180.0/255.0 alpha:1.0];
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.verticalDividerEnabled = YES;
    self.segmentedControl.verticalDividerWidth = 1.0f;
    self.segmentedControl.verticalDividerColor = MAINCOLOR;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.segmentedControl.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"ArialMT" size:16.0]};
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.myScrollView scrollRectToVisible:CGRectMake(weakSelf.view.frame.size.width * index, 0, weakSelf.view.frame.size.width, 200) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 105.0, SCREEN_WIDTH, SCREEN_HEIGHT - 105.0)];
    self.myScrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT - 105.0);
    self.myScrollView.delegate = self;
    [self.myScrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 105.0) animated:NO];
    self.myScrollView.scrollEnabled = NO;
    [self.view addSubview:self.myScrollView];
    
    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT -SCREEN_WIDTH/2.0 - 105.0)];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    [self.messageTableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"messageCell"];
    [self.myScrollView addSubview:self.messageTableView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - 105.0)];
    [self.myScrollView addSubview:view1];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lookingforward"]];
    [view1 addSubview:imageview1];
    
    [imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view1);
        make.size.mas_equalTo(CGSizeMake(128, 128));
    }];
    
    
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
    return [self.messageArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
 
     // Configure the cell...
     if (cell == nil) {
         cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
         cell.separatorInset = UIEdgeInsetsZero;
     }
 
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

#pragma mark - InboxService delegate

- (void)returnMyMessage:(NSArray *)dataArray {
    self.messageArray = dataArray;
    [self.messageTableView reloadData];
}

@end
