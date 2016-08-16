//
//  LeftSideViewController.m
//  MedicalTech
//
//  Created by Jason on 7/26/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "LeftSideViewController.h"

@interface LeftSideViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *avatarImage;
    UIButton *takePhoto;
    UILabel *nameLabel;
    UILabel *titleLabel;
    UILabel *numberLabel;
    UILabel *mobileLabel;
    UILabel *emailLabel;
    UITableView *listTableView;
}

@end

@implementation LeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    avatarImage = [[UIImageView alloc] init];
    avatarImage.image = [UIImage imageNamed:@"testAvatar"];
    [self.view addSubview:avatarImage];
    
    [avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarImage.superview);
        make.left.equalTo(avatarImage.superview);
        make.right.equalTo(avatarImage.superview);
        make.height.equalTo(avatarImage.mas_width).multipliedBy(203.0/360.0);
    }];
    
    takePhoto = [[UIButton alloc] init];
    [takePhoto setImage:[UIImage imageNamed:@"takephoto"] forState:UIControlStateNormal];
    [self.view addSubview:takePhoto];
    
    [takePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(takePhoto.superview).offset(-21.0);
        make.centerY.equalTo(avatarImage.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(48.0, 48.0));
    }];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"Cristina";
    nameLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarImage.mas_bottom).offset(17);
        make.left.equalTo(nameLabel.superview).offset(21);
        make.size.mas_equalTo(CGSizeMake(160, 18));
    }];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"主任医师";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.left.equalTo(titleLabel.superview).offset(21);
        make.size.mas_equalTo(CGSizeMake(160, 16));
    }];
    
    numberLabel = [[UILabel alloc] init];
    numberLabel.text = @"188088";
    numberLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.left.equalTo(numberLabel.superview).offset(21);
        make.size.mas_equalTo(CGSizeMake(160, 16));
    }];
    
    mobileLabel = [[UILabel alloc] init];
    mobileLabel.text = @"13812345678";
    mobileLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:mobileLabel];
    
    [mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLabel.mas_bottom).offset(8);
        make.left.equalTo(mobileLabel.superview).offset(21);
        make.size.mas_equalTo(CGSizeMake(160, 16));
    }];
    
    emailLabel = [[UILabel alloc] init];
    emailLabel.text = @"test1986@gmail.com";
    emailLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:emailLabel];
    
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileLabel.mas_bottom).offset(8);
        make.left.equalTo(emailLabel.superview).offset(21);
        make.size.mas_equalTo(CGSizeMake(160, 16));
    }];
    
    listTableView = [[UITableView alloc] init];
    [listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listTableCell"];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    
    [listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(listTableView.superview);
        make.right.equalTo(listTableView.superview);
        make.top.equalTo(emailLabel.mas_bottom).offset(20);
        make.bottom.equalTo(listTableView.superview);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTableCell" forIndexPath:indexPath];
 
     // Configure the cell...
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"listTableCell"];
     }
     
     switch (indexPath.row) {
         case 0:
         {
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inbox"]];
             [cell.contentView addSubview:imageView];
             
             [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.superview).offset(21);
                 make.top.equalTo(imageView.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(32, 32));
             }];
             
             UILabel *contentLabel = [[UILabel alloc] init];
             contentLabel.text = @"收件箱";
             contentLabel.font = [UIFont systemFontOfSize:16];
             [cell.contentView addSubview:contentLabel];
             
             [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.mas_right).offset(21);
                 make.top.equalTo(contentLabel.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(120, 32));
             }];
             
             break;
         }
         case 1:
         {
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mywatch"]];
             [cell.contentView addSubview:imageView];
             
             [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.superview).offset(21);
                 make.top.equalTo(imageView.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(32, 32));
             }];
             
             UILabel *contentLabel = [[UILabel alloc] init];
             contentLabel.text = @"我的订阅";
             contentLabel.font = [UIFont systemFontOfSize:16];
             [cell.contentView addSubview:contentLabel];
             
             [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.mas_right).offset(21);
                 make.top.equalTo(contentLabel.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(120, 32));
             }];
             break;
         }
         case 2:
         {
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"studyplan"]];
             [cell.contentView addSubview:imageView];
             
             [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.superview).offset(21);
                 make.top.equalTo(imageView.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(32, 32));
             }];
             
             UILabel *contentLabel = [[UILabel alloc] init];
             contentLabel.text = @"学习计划";
             contentLabel.font = [UIFont systemFontOfSize:16];
             [cell.contentView addSubview:contentLabel];
             
             [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.mas_right).offset(21);
                 make.top.equalTo(contentLabel.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(120, 32));
             }];
             break;
         }
         case 3:
         {
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"help"]];
             [cell.contentView addSubview:imageView];
             
             [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.superview).offset(21);
                 make.top.equalTo(imageView.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(32, 32));
             }];
             
             UILabel *contentLabel = [[UILabel alloc] init];
             contentLabel.text = @"使用帮助";
             contentLabel.font = [UIFont systemFontOfSize:16];
             [cell.contentView addSubview:contentLabel];
             
             [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.mas_right).offset(21);
                 make.top.equalTo(contentLabel.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(120, 32));
             }];
             break;
         }
         case 4:
         {
             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting"]];
             [cell.contentView addSubview:imageView];
             
             [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.superview).offset(21);
                 make.top.equalTo(imageView.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(32, 32));
             }];
             
             UILabel *contentLabel = [[UILabel alloc] init];
             contentLabel.text = @"系统设置";
             contentLabel.font = [UIFont systemFontOfSize:16];
             [cell.contentView addSubview:contentLabel];
             
             [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(imageView.mas_right).offset(21);
                 make.top.equalTo(contentLabel.superview).offset(14);
                 make.size.mas_equalTo(CGSizeMake(120, 32));
             }];
             break;
         }
         default:
             break;
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

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
