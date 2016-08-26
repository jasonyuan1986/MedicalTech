//
//  SettingsViewController.m
//  MedicalTech
//
//  Created by Jason on 8/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "SettingsViewController.h"
#import "SignService.h"

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource, SignServiceDelegate>
{
    UITableView *myTableView;
    UIButton *logoutButton;
}

@end

@implementation SettingsViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    myTableView.scrollEnabled = NO;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.separatorInset = UIEdgeInsetsZero;
    myTableView.layoutMargins = UIEdgeInsetsZero;
    [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"settingCell"];
    UIView *header = [[UIView alloc] initWithFrame:CGRectZero];
    [myTableView setTableHeaderView:header];
    
    [self.view addSubview:myTableView];
    
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 200));
    }];
    
    logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton setBackgroundColor:MAINCOLOR];
    [logoutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
    }];
}

- (void)logout:(id)sender {
    SignService *signService = [[SignService alloc] init];
    signService.delegate = self;
    [signService signout];
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            UIImageView *preImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_person"]];
            [cell.contentView addSubview:preImage];
            
            [preImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(5);
                make.top.equalTo(cell.contentView).offset(4);
                make.size.mas_equalTo(CGSizeMake(32, 32));
            }];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.text = @"账户管理";
            [cell.contentView addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preImage.mas_right).offset(10);
                make.top.equalTo(cell.contentView).offset(4);
                make.size.mas_equalTo(CGSizeMake(120, 32));
            }];
            
            break;
        }
        case 1:
        {
            UIImageView *preImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_unlock"]];
            [cell.contentView addSubview:preImage];
            
            [preImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(9);
                make.top.equalTo(cell.contentView).offset(4);
                make.size.mas_equalTo(CGSizeMake(24, 32));
            }];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.text = @"修改密码";
            [cell.contentView addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preImage.mas_right).offset(14);
                make.top.equalTo(cell.contentView).offset(4);
                make.size.mas_equalTo(CGSizeMake(120, 32));
            }];
            
            break;
        }
        default:
            break;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            [self.delegate goToResetPassword];
            break;
        }
        default:
            break;
    }
}

#pragma mark - SignServiceDelegate

- (void)logoutSuccess {
    [self.delegate logoutSuccess];
}

@end
