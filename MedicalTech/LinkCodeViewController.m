//
//  LinkCodeViewController.m
//  MedicalTech
//
//  Created by Jason on 8/2/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "LinkCodeViewController.h"
#import "RegisterService.h"

@interface LinkCodeViewController () <UITextFieldDelegate>
{
    UILabel *authPhoneLabel;
    UILabel *setauthCodeLabel;
    UILabel *linkCodeLabel;
    UILabel *bindLabel;
    UITextField *bindField;
    UIButton *bind;
}

@end

@implementation LinkCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定工号";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelRegister:)];
    self.navigationItem.rightBarButtonItem = cancelButtonItem;

    authPhoneLabel = [[UILabel alloc] init];
    authPhoneLabel.text = @"1.验证手机";
    authPhoneLabel.textColor = [UIColor whiteColor];
    authPhoneLabel.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:174.0/255.0 alpha:1.0];
    authPhoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:authPhoneLabel];

    [authPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authPhoneLabel.superview).offset(15);
        make.top.equalTo(authPhoneLabel.superview).offset(100);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/3.0, 30));
    }];

    setauthCodeLabel = [[UILabel alloc] init];
    setauthCodeLabel.text = @"2.设置密码";
    setauthCodeLabel.textColor = [UIColor whiteColor];
    setauthCodeLabel.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:174.0/255.0 alpha:1.0];
    setauthCodeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:setauthCodeLabel];

    [setauthCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authPhoneLabel.mas_right);
        make.top.equalTo(authPhoneLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/3.0, 30));
    }];

    linkCodeLabel = [[UILabel alloc] init];
    linkCodeLabel.text = @"3.关联工号";
    linkCodeLabel.textColor = [UIColor whiteColor];
    linkCodeLabel.backgroundColor = MAINCOLOR;
    linkCodeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:linkCodeLabel];

    [linkCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(setauthCodeLabel.mas_right);
        make.top.equalTo(authPhoneLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/3.0, 30));
    }];

    bindLabel = [[UILabel alloc] init];
    bindLabel.text = @"绑定工号";
    bindLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bindLabel];

    [bindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authPhoneLabel.mas_bottom).offset(10);
        make.left.equalTo(bindLabel.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];

    bindField = [[UITextField alloc] init];
    bindField.delegate = self;
    bindField.layer.cornerRadius = 5;
    bindField.layer.borderWidth = 1;
    bindField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    bindField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    bindField.font = [UIFont systemFontOfSize:16];
    bindField.secureTextEntry = YES;
    [self.view addSubview:bindField];
    
    [bindField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authPhoneLabel.mas_bottom).offset(10);
        make.left.equalTo(bindLabel.mas_right).offset(10);
        make.right.equalTo(bindField.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    bind = [UIButton buttonWithType:UIButtonTypeSystem];
    [bind setTitle:@"完成" forState:UIControlStateNormal];
    [bind setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bind setBackgroundColor:MAINCOLOR];
    [bind addTarget:self action:@selector(bindNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bind];
    
    [bind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bindField.mas_bottom).offset(15);
        make.left.equalTo(bind.superview).offset(35);
        make.right.equalTo(bind.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
}

- (void)cancelRegister:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)bindNo:(id)sender {
    RegisterService *registerService = [[RegisterService alloc] init];
    [registerService bindNo:bindField.text];
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

#pragma mark - RegisterServiceDelegate

- (void)bindNoSuccess {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
