//
//  InboxDetailViewController.m
//  MedicalTech
//
//  Created by Jason on 12/09/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "InboxDetailViewController.h"

@interface InboxDetailViewController ()
{
    UILabel *titleLabel;
    UITextView *contentTextView;
    UILabel *dateLabel;
}

@end

@implementation InboxDetailViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的消息";
    [self initUI];
    [self setData];
}

- (void)initUI {
    titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(84);
        make.height.mas_equalTo(30);
    }];
    
    contentTextView = [[UITextView alloc] init];
    contentTextView.editable = NO;
    [self.view addSubview:contentTextView];
    
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    
    dateLabel = [[UILabel alloc] init];
    dateLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:dateLabel];
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(20);
    }];
}

- (void)setData {
    NSString *title = [self.data objectForKey:@"title"];
    NSString *content = [self.data objectForKey:@"remark"];
    NSString *date = [self.data objectForKey:@"createDt"];
    
    titleLabel.text = title;
    contentTextView.text = content;
    dateLabel.text = [date substringWithRange:NSMakeRange(0, 10)];
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

@end
