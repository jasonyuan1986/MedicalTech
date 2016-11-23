//
//  GetSmsViewController.m
//  MedicalTech
//
//  Created by Jason on 8/2/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "GetSmsViewController.h"
#import "SetPasswordViewController.h"
#import "RegisterService.h"
#import "SMSService.h"

@interface GetSmsViewController () <UITextFieldDelegate, RegisterServiceDelegate>
{
    UILabel *authPhoneLabel;
    UILabel *setauthCodeLabel;
    UILabel *linkCodeLabel;
    UILabel *mobileLabel;
    UITextField *mobileField;
    UILabel *authCodeLabel;
    UITextField *authCodeField;
    UIButton *getAuthCode;
    UIButton *next;
    SetPasswordViewController *setPasswordViewController;
    int count;
}

@end

@implementation GetSmsViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [mobileField resignFirstResponder];
    [authCodeField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"验证手机";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self initUI];
}

- (void)cancelRegister:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)initUI {
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelRegister:)];
    self.navigationItem.rightBarButtonItem = cancelButtonItem;
    
    authPhoneLabel = [[UILabel alloc] init];
    authPhoneLabel.text = @"1.验证手机";
    authPhoneLabel.textColor = [UIColor whiteColor];
    authPhoneLabel.backgroundColor = MAINCOLOR;
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
    linkCodeLabel.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:174.0/255.0 alpha:1.0];
    linkCodeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:linkCodeLabel];
    
    [linkCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(setauthCodeLabel.mas_right);
        make.top.equalTo(authPhoneLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/3.0, 30));
    }];
    
    mobileLabel = [[UILabel alloc] init];
    mobileLabel.text = @"手机号";
    mobileLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:mobileLabel];
    
    [mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authPhoneLabel.mas_bottom).offset(60);
        make.left.equalTo(mobileLabel.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(60.0, 30.0));
    }];
    
    mobileField = [[UITextField alloc] init];
    mobileField.tag = 1;
    mobileField.delegate = self;
    mobileField.keyboardType = UIKeyboardTypePhonePad;
    mobileField.layer.cornerRadius = 5;
    mobileField.layer.borderWidth = 1;
    mobileField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    mobileField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    mobileField.font = [UIFont systemFontOfSize:16];
    mobileField.textColor = MAINCOLOR;
    [self.view addSubview:mobileField];
    
    [mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authPhoneLabel.mas_bottom).offset(60);
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
    authCodeField.keyboardType = UIKeyboardTypePhonePad;
    authCodeField.layer.cornerRadius = 5;
    authCodeField.layer.borderWidth = 1;
    authCodeField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    authCodeField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    authCodeField.font = [UIFont systemFontOfSize:16];
    authCodeField.secureTextEntry = YES;
    [self.view addSubview:authCodeField];
    
    [authCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileField.mas_bottom).offset(10);
        make.left.equalTo(authCodeLabel.mas_right).offset(10);
        make.right.equalTo(mobileField.superview).offset(-150);
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
    
    next = [UIButton buttonWithType:UIButtonTypeSystem];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next setBackgroundColor:MAINCOLOR];
    [next addTarget:self action:@selector(goToNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authCodeField.mas_bottom).offset(15);
        make.left.equalTo(next.superview).offset(35);
        make.right.equalTo(next.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
}

- (void)viewTaped:(id)sender {
    [mobileField resignFirstResponder];
    [authCodeField resignFirstResponder];
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

- (void)getAuthCode:(id)sender {
    [self initTimer];
    
    [SMSService getSms:mobileField.text smsType:@"2"];
}

- (void)goToNext:(id)sender {
    RegisterService *registerService = [[RegisterService alloc] init];
    registerService.delegate = self;
    [registerService mobileRegister:mobileField.text validCode:authCodeField.text];
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
        mobileLabel.textColor = MAINCOLOR;
        mobileField.layer.borderColor = MAINCOLOR.CGColor;
    } else {
        authCodeLabel.textColor = MAINCOLOR;
        authCodeField.layer.borderColor = MAINCOLOR.CGColor;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        mobileLabel.textColor = [UIColor blackColor];
        mobileField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    } else {
        authCodeLabel.textColor = [UIColor blackColor];
        authCodeField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    }
}

#pragma mark - RegisterServiceDelegate

- (void)registerTokenCallBack:(NSString *)registerToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:registerToken forKey:@"token"];
    
    if (setPasswordViewController) {
        [self.navigationController pushViewController:setPasswordViewController animated:YES];
    } else {
        setPasswordViewController = [[SetPasswordViewController alloc] init];
        [self.navigationController pushViewController:setPasswordViewController animated:YES];
    }
}

@end
