//
//  PlayerViewController.m
//  MedicalTech
//
//  Created by Jason on 7/20/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "PlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <DZVideoPlayerViewController/DZVideoPlayerViewControllerContainerView.h>
#import <DZVideoPlayerViewController/DZVideoPlayerViewController.h>

@interface PlayerViewController () <DZVideoPlayerViewControllerDelegate>

@property (nonatomic, strong) AVPlayerViewController *playerViewController;
@property (nonatomic, strong) NSDictionary *videoData;
@property (nonatomic, strong) DZVideoPlayerViewControllerContainerView *videoPlayerViewControllerContainerView;
@property (strong, nonatomic) DZVideoPlayerViewController *videoPlayerViewController;

@end

@implementation PlayerViewController

@synthesize exam_id;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[NSString stringWithFormat:@"%@%@.do", VIDEODETAIL, self.exam_id] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        self.videoData = [dictionary objectForKey:@"data"];
        
        NSString *movieUrl = [self.videoData objectForKey:@"movieUrl"];
        NSURL *sourceMovieUrl = [NSURL URLWithString:movieUrl];
        self.videoPlayerViewController.videoURL = sourceMovieUrl;
        [self.videoPlayerViewController prepareAndPlayAutomatically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.videoPlayerViewController stop];
    [self.videoPlayerViewController.playerView.player.currentItem cancelPendingSeeks];
    [self.videoPlayerViewController.playerView.player.currentItem.asset cancelLoading];
    self.videoPlayerViewControllerContainerView = nil;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"医学移动教育平台";
    
    self.videoPlayerViewControllerContainerView = [[DZVideoPlayerViewControllerContainerView alloc] init];
    self.videoPlayerViewController = self.videoPlayerViewControllerContainerView.videoPlayerViewController;
    self.videoPlayerViewController.topToolbarView.hidden = YES;
    self.videoPlayerViewController.delegate = self;
    [self.view addSubview:self.videoPlayerViewControllerContainerView];
    [self.videoPlayerViewControllerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view);
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

#pragma mark- DZVideoPlayerViewControllerDelegate

- (void)playerDidPlay {
    
}

@end
