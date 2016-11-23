//
//  HelpViewController.m
//  MedicalTech
//
//  Created by Jason on 9/7/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "HelpViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface HelpViewController () <UIWebViewDelegate>
{
    UIWebView *myWebView;
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"使用帮助";
    
    myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *helpURL = [defaults objectForKey:@"helpURL"];
    
    [MBProgressHUD showHUDAddedTo:myWebView animated:YES].dimBackground = YES;
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:helpURL]]];
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

#pragma mark - Web view delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:myWebView animated:YES];
}

@end
