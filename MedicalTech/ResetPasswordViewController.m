//
//  ResetPasswordViewController.m
//  MedicalTech
//
//  Created by Jason on 8/3/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "SMSService.h"
#import "RegisterService.h"

@interface ResetPasswordViewController () <UITextFieldDelegate, RegisterServiceDelegate>
{
    UIImageView *logoImageView;
    UILabel *titleLabel;
    UILabel *mobileLabel;
    UITextField *mobileField;
    UILabel *authCodeLabel;
    UITextField *authCodeField;
    UIButton *getAuthCode;
    UILabel *passwordLabel;
    UITextField *passwordField;
    UIButton *reset;
    int count;
}

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"重置密码";
    
    [self initUI];
}

- (void)initUI {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"loginimage"];
    [self.view addSubview:logoImageView];
    
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.superview).offset(80);
        make.left.equalTo(logoImageView.superview).offset(35);
        make.right.equalTo(logoImageView.superview).offset(-35);
        make.height.equalTo(logoImageView.mas_width).multipliedBy(108.0/166.0);
    }];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"河南网络学院";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = MAINCOLOR;
    titleLabel.font = [UIFont systemFontOfSize:26];
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(20);
        make.left.equalTo(titleLabel.superview).offset(35);
        make.right.equalTo(titleLabel.superview).offset(-35);
        make.height.mas_equalTo(30.0);
    }];
    
    mobileLabel = [[UILabel alloc] init];
    mobileLabel.text = @"手机号";
    mobileLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:mobileLabel];
    
    [mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.equalTo(mobileLabel.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    mobileField = [[UITextField alloc] init];
    mobileField.tag = 1;
    mobileField.delegate = self;
    mobileField.layer.cornerRadius = 5;
    mobileField.layer.borderWidth = 1;
    mobileField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    mobileField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    mobileField.font = [UIFont systemFontOfSize:16];
    mobileField.textColor = MAINCOLOR;
    [self.view addSubview:mobileField];
    
    [mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.equalTo(mobileLabel.mas_right).offset(10);
        make.right.equalTo(mobileField.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    authCodeLabel = [[UILabel alloc] init];
    authCodeLabel.text = @"验证码";
    authCodeLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:authCodeLabel];
    
    [authCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileField.mas_bottom).offset(10);
        make.left.equalTo(authCodeLabel.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(60.0, 30.0));
    }];
    
    authCodeField = [[UITextField alloc] init];
    authCodeField.tag = 2;
    authCodeField.delegate = self;
    authCodeField.layer.cornerRadius = 5;
    authCodeField.layer.borderWidth = 1;
    authCodeField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    authCodeField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    authCodeField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:authCodeField];
    
    [authCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileField.mas_bottom).offset(10);
        make.left.equalTo(authCodeLabel.mas_right).offset(10);
        make.right.equalTo(authCodeField.superview).offset(-150);
        make.height.mas_equalTo(30);
    }];
    
    getAuthCode = [UIButton buttonWithType:UIButtonTypeSystem];
    [getAuthCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getAuthCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getAuthCode setBackgroundColor:MAINCOLOR];
    [getAuthCode addTarget:self action:@selector(getAuthCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getAuthCode];
    
    [getAuthCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authCodeField.mas_right).offset(15);
        make.top.equalTo(authCodeField.mas_top);
        make.right.equalTo(getAuthCode.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"输入密码";
    passwordLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:passwordLabel];
    
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getAuthCode.mas_bottom).offset(10);
        make.left.equalTo(passwordLabel.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(60.0, 30.0));
    }];
    
    passwordField = [[UITextField alloc] init];
    passwordField.tag = 3;
    passwordField.delegate = self;
    passwordField.layer.cornerRadius = 5;
    passwordField.layer.borderWidth = 1;
    passwordField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    passwordField.font = [UIFont systemFontOfSize:16];
    passwordField.textColor = MAINCOLOR;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getAuthCode.mas_bottom).offset(10);
        make.left.equalTo(passwordLabel.mas_right).offset(10);
        make.right.equalTo(passwordField.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    reset = [UIButton buttonWithType:UIButtonTypeSystem];
    [reset setTitle:@"重置密码" forState:UIControlStateNormal];
    [reset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reset setBackgroundColor:MAINCOLOR];
    [reset addTarget:self action:@selector(resetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reset];
    
    [reset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(15);
        make.left.equalTo(reset.superview).offset(35);
        make.right.equalTo(reset.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
}

- (void)initTimer {
    getAuthCode.enabled = NO;
    [getAuthCode setBackgroundColor:[UIColor grayColor]];
    count = 30;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(authCountDown:) userInfo:nil repeats:YES];
}

- (void)authCountDown:(id)sender {
    NSTimer *timer = (NSTimer *)sender;
    [getAuthCode setTitle:[NSString stringWithFormat:@"%ds后重发", count] forState:UIControlStateNormal];
    count--;
    if (count == 0) {
        [timer invalidate];
        getAuthCode.enabled = YES;
        [getAuthCode setBackgroundColor:MAINCOLOR];
        [getAuthCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)viewTaped:(id)sender {
    [mobileField resignFirstResponder];
    [authCodeField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (void)getAuthCode:(id)sender {
    [self initTimer];
    
    [SMSService getSms:mobileField.text smsType:@"3"];
}

- (void)resetPassword:(id)sender {
    RegisterService *registerService = [[RegisterService alloc] init];
    registerService.delegate = self;
    [registerService resetPassword:mobileField.text authCode:authCodeField.text newPassword:passwordField.text];
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
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 216, self.view.frame.size.width, self.view.frame.size.height);
    if (textField.tag == 1) {
        mobileLabel.textColor = MAINCOLOR;
        mobileField.layer.borderColor = MAINCOLOR.CGColor;
    } else if (textField.tag == 3) {
        passwordLabel.textColor = MAINCOLOR;
        passwordField.layer.borderColor = MAINCOLOR.CGColor;
    } else {
        authCodeLabel.textColor = MAINCOLOR;
        authCodeField.layer.borderColor = MAINCOLOR.CGColor;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 216, self.view.frame.size.width, self.view.frame.size.height);
    if (textField.tag == 1) {
        mobileLabel.textColor = [UIColor blackColor];
        mobileField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    } else if (textField.tag == 3) {
        passwordLabel.textColor = [UIColor blackColor];
        passwordField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    } else {
        authCodeLabel.textColor = [UIColor blackColor];
        authCodeField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    }
}

#pragma mark - RegisterService delegate

- (void)resetPasswordSuccess {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
