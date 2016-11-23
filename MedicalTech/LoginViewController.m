//
//  LoginViewController.m
//  MedicalTech
//
//  Created by Jason on 7/27/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "LoginViewController.h"
#import "ResetPasswordViewController.h"
#import "GetSmsViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import "LeftSideViewController.h"
#import "IndexViewController.h"
#import "PlayerViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
{
    UIImageView *logoImageView;
    UILabel *titleLabel;
    UILabel *mobileLabel;
    UITextField *mobileField;
    UILabel *passwordLabel;
    UITextField *passwordField;
    UIButton *signinButton;
    UIButton *forgetPassword;
    UIButton *firstLaunch;
    ResetPasswordViewController *resetPasswordViewController;
    GetSmsViewController *getSmsViewController;
    
    BOOL willEndEditing;
}

@property (nonatomic, strong) MMDrawerController *drawerController;

@end

@implementation LoginViewController

@synthesize delegate;

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [mobileField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登陆";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self initUI];
}

- (void)initUI {
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
        make.right.equalTo(mobileLabel.superview).offset(-35);
        make.height.mas_equalTo(12);
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
        make.top.equalTo(mobileLabel.mas_bottom).offset(10);
        make.left.equalTo(mobileField.superview).offset(35);
        make.right.equalTo(mobileField.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"密码";
    passwordLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:passwordLabel];
    
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileField.mas_bottom).offset(10);
        make.left.equalTo(passwordLabel.superview).offset(35);
        make.right.equalTo(passwordLabel.superview).offset(-35);
        make.height.mas_equalTo(12);
    }];
    
    passwordField = [[UITextField alloc] init];
    passwordField.tag = 2;
    passwordField.delegate = self;
    passwordField.keyboardType = UIKeyboardTypeNamePhonePad;
    passwordField.layer.cornerRadius = 5;
    passwordField.layer.borderWidth = 1;
    passwordField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    passwordField.font = [UIFont systemFontOfSize:16];
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel.mas_bottom).offset(10);
        make.left.equalTo(passwordField.superview).offset(35);
        make.right.equalTo(passwordField.superview).offset(-35);
        make.height.mas_equalTo(30);
    }];
    
    signinButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [signinButton setTitle:@"登录" forState:UIControlStateNormal];
    [signinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signinButton setBackgroundColor:MAINCOLOR];
    signinButton.layer.cornerRadius = 5;
    [signinButton addTarget:self action:@selector(signin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signinButton];
    
    [signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).offset(20);
        make.left.equalTo(signinButton.superview).offset(35);
        make.right.equalTo(signinButton.superview).offset(-35);
        make.height.mas_equalTo(36);
    }];
    
    forgetPassword = [UIButton buttonWithType:UIButtonTypeSystem];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"忘记密码"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange];
    [forgetPassword setAttributedTitle:title forState:UIControlStateNormal];
    [forgetPassword addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassword];
    
    [forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(signinButton.mas_bottom).offset(8);
        make.left.equalTo(forgetPassword.superview).offset(35);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    firstLaunch = [UIButton buttonWithType:UIButtonTypeSystem];
    NSMutableAttributedString *title2 = [[NSMutableAttributedString alloc] initWithString:@"首次登陆"];
    NSRange titleRange2 = {0,[title2 length]};
    [title2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange2];
    [title2 addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange];
    [firstLaunch setAttributedTitle:title2 forState:UIControlStateNormal];
    [firstLaunch addTarget:self action:@selector(goToRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstLaunch];
    
    [firstLaunch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(signinButton.mas_bottom).offset(8);
        make.right.equalTo(forgetPassword.superview).offset(-35);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
}

- (void)signin:(id)sender {
    NSString *requestUrl = [NSString stringWithFormat:@"%@mobileNo=%@&pwd=%@", LOGIN, mobileField.text, passwordField.text];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSNumber *ret = [dictionary objectForKey:@"ret"];
        
        if ([ret intValue] == 0) {
            NSDictionary *data = [dictionary objectForKey:@"data"];
            NSString *token = [data objectForKey:@"token"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:token forKey:@"token"];
            
            [self.delegate loginSuccess];
        } else if ([ret intValue] == 10056) {
            
        } else {
            [MBProgressUtil MBShowMessage:[dictionary objectForKey:@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Sign In error:%@", error);
    }];
}

- (void)viewTaped:(id)sender {
    YYKeyboardManager *manager = [YYKeyboardManager defaultManager];
    if (manager.keyboardVisible) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.18];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 216, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
    
    [mobileField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (void)forgetPassword:(id)sender {
    if (resetPasswordViewController) {
        [self.navigationController pushViewController:resetPasswordViewController animated:YES];
    } else {
        resetPasswordViewController = [[ResetPasswordViewController alloc] init];
        [self.navigationController pushViewController:resetPasswordViewController animated:YES];
    }
}

- (void)goToRegister:(id)sender {
    if (getSmsViewController) {
        [self.navigationController pushViewController:getSmsViewController animated:YES];
    } else {
        getSmsViewController = [[GetSmsViewController alloc] init];
        [self.navigationController pushViewController:getSmsViewController animated:YES];
    }
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
    YYKeyboardManager *manager = [YYKeyboardManager defaultManager];
    if (!manager.keyboardVisible) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.42];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 216, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
    if (textField.tag == 1) {
        mobileLabel.textColor = MAINCOLOR;
        mobileField.layer.borderColor = MAINCOLOR.CGColor;
    } else {
        passwordLabel.textColor = MAINCOLOR;
        passwordField.layer.borderColor = MAINCOLOR.CGColor;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    YYKeyboardManager *manager = [YYKeyboardManager defaultManager];
//    if (!manager.keyboardVisible) {
//    }
    

    if (textField.tag == 1) {
        mobileLabel.textColor = [UIColor blackColor];
        mobileField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    } else {
        passwordLabel.textColor = [UIColor blackColor];
        passwordField.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0].CGColor;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
