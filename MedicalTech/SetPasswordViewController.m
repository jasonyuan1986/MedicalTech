//
//  nextViewController.m
//  MedicalTech
//
//  Created by Jason on 8/2/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "LinkCodeViewController.h"
#import "RegisterService.h"

@interface SetPasswordViewController () <UITextFieldDelegate, RegisterServiceDelegate>
{
    UILabel *authPhoneLabel;
    UILabel *setagainLabel;
    UILabel *linkCodeLabel;
    UILabel *passwordLabel;
    UITextField *passwordField;
    UILabel *againLabel;
    UITextField *againField;
    UIButton *next;
    LinkCodeViewController *linkCodeViewController;
}

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置密码";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;

    
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
    
    setagainLabel = [[UILabel alloc] init];
    setagainLabel.text = @"2.设置密码";
    setagainLabel.textColor = [UIColor whiteColor];
    setagainLabel.backgroundColor = MAINCOLOR;
    setagainLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:setagainLabel];
    
    [setagainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authPhoneLabel.mas_right);
        make.top.equalTo(authPhoneLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/3.0, 30));
    }];
    
    linkCodeLabel = [[UILabel alloc] init];
    linkCodeLabel.text = @"3.关联工号";
    linkCodeLabel.textColor = [UIColor whiteColor];
    linkCodeLabel.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:174.0/255.0 alpha:1.0];
    linkCodeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:linkCodeLabel];
    
    [linkCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(setagainLabel.mas_right);
        make.top.equalTo(authPhoneLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/3.0, 30));
    }];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"输入密码";
    passwordLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:passwordLabel];
    
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authPhoneLabel.mas_bottom).offset(60);
        make.left.equalTo(passwordLabel.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(60.0, 30.0));
    }];
    
    passwordField = [[UITextField alloc] init];
    passwordField.tag = 1;
    passwordField.delegate = self;
    passwordField.layer.cornerRadius = 5;
    passwordField.layer.borderWidth = 1;
    passwordField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    passwordField.font = [UIFont systemFontOfSize:16];
    passwordField.textColor = MAINCOLOR;
    [self.view addSubview:passwordField];
    
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authPhoneLabel.mas_bottom).offset(60);
        make.left.equalTo(passwordLabel.mas_right).offset(10);
        make.right.equalTo(passwordField.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    againLabel = [[UILabel alloc] init];
    againLabel.text = @"再次确认";
    againLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:againLabel];
    
    [againLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(10);
        make.left.equalTo(againLabel.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(60.0, 30.0));
    }];
    
    againField = [[UITextField alloc] init];
    againField.tag = 2;
    againField.delegate = self;
    againField.layer.cornerRadius = 5;
    againField.layer.borderWidth = 1;
    againField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    againField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    againField.font = [UIFont systemFontOfSize:16];
    againField.secureTextEntry = YES;
    [self.view addSubview:againField];
    
    [againField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(10);
        make.left.equalTo(againLabel.mas_right).offset(10);
        make.right.equalTo(passwordField.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    next = [UIButton buttonWithType:UIButtonTypeSystem];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next setBackgroundColor:MAINCOLOR];
    [next addTarget:self action:@selector(goToNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(againField.mas_bottom).offset(15);
        make.left.equalTo(next.superview).offset(35);
        make.right.equalTo(next.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
}

- (void)cancelRegister:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goToNext:(id)sender {
    RegisterService *registerService = [[RegisterService alloc] init];
    registerService.delegate = self;
    [registerService setNewPassword:passwordField.text];
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        passwordLabel.textColor = MAINCOLOR;
        passwordField.layer.borderColor = MAINCOLOR.CGColor;
    } else {
        againLabel.textColor = MAINCOLOR;
        againField.layer.borderColor = MAINCOLOR.CGColor;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        passwordLabel.textColor = [UIColor blackColor];
        passwordField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    } else {
        againLabel.textColor = [UIColor blackColor];
        againField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    }
}

#pragma mark - RegisterServiceDelegate

- (void)setNewPasswordSuccess {    
    if (linkCodeViewController) {
        [self.navigationController pushViewController:linkCodeViewController animated:YES];
    } else {
        linkCodeViewController = [[LinkCodeViewController alloc] init];
        [self.navigationController pushViewController:linkCodeViewController animated:YES];
    }
}

@end
