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
#import "CourseMovieListService.h"
#import "RelatedCollectionViewCell.h"
#import <AVKit/AVPlayerViewController.h>

#define PAGESIZE 4

@interface PlayerViewController () <DZVideoPlayerViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CourseMovieListServiceDelegate>
{
    UIScrollView *myScrollView;
    
    UIView *backView;
    UIImageView *scoreImage;
    UILabel* scoreLabel;
    UIImageView *playNumberImage;
    UILabel *playNumberLabel;
    
    UIView *contentBackView;
    UILabel *contentTitleLabel;
    UITextView *contentTextView;
    UIButton *hideExpandButton;
    
    UICollectionView *relatedMovieView;
    UIView *headerView;
    UIButton *moreMovie;
    
    int pageNo;
}

@property (nonatomic, strong) AVPlayerViewController *playerViewController;
@property (nonatomic, strong) NSDictionary *videoData;
@property (nonatomic, strong) NSMutableArray *relatedArray;
@property (nonatomic, strong) DZVideoPlayerViewControllerContainerView *videoPlayerViewControllerContainerView;
@property (strong, nonatomic) DZVideoPlayerViewController *videoPlayerViewController;

@end

@implementation PlayerViewController

@synthesize exam_id;
@synthesize subject_id;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[NSString stringWithFormat:@"%@%@.do", VIDEODETAIL, self.exam_id] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        self.videoData = [dictionary objectForKey:@"data"];
        
        NSString *movieUrl = [self.videoData objectForKey:@"movieUrl"];
        NSURL *sourceMovieUrl = [NSURL URLWithString:movieUrl];
        self.videoPlayerViewController.videoURL = sourceMovieUrl;
        [self.videoPlayerViewController prepareAndPlayAutomatically:YES];
        scoreLabel.text = [NSString stringWithFormat:@"学分 %@", [self.videoData objectForKey:@"point"]];
        playNumberLabel.text = [NSString stringWithFormat:@"%@次播放", [self.videoData objectForKey:@"total_time"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
    [self.videoPlayerViewController stop];
    [self.videoPlayerViewController.playerView.player.currentItem cancelPendingSeeks];
    [self.videoPlayerViewController.playerView.player.currentItem.asset cancelLoading];
    self.videoPlayerViewControllerContainerView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:232.0/255.0 blue:235.0/255.0 alpha:1.0];
    self.title = @"医学移动教育平台";
    
    [self initUI];
}

- (void)initUI {
    self.videoPlayerViewControllerContainerView = [[DZVideoPlayerViewControllerContainerView alloc] initWithStyle:DZVideoPlayerViewControllerStyleSimple];
    self.videoPlayerViewController = self.videoPlayerViewControllerContainerView.videoPlayerViewController;
    self.videoPlayerViewController.topToolbarView.hidden = YES;
    self.videoPlayerViewController.delegate = self;
    [self.view addSubview:self.videoPlayerViewControllerContainerView];
    [self.videoPlayerViewControllerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(self.videoPlayerViewControllerContainerView.mas_width).multipliedBy(235.0/360.0);
    }];
    
    myScrollView = [[UIScrollView alloc] init];
    myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 600);
    [self.view addSubview:myScrollView];
    
    [myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.videoPlayerViewControllerContainerView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myScrollView);
        make.top.equalTo(myScrollView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 42));
    }];
    
    scoreImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scoreimage"]];
    [backView addSubview:scoreImage];
    
    [scoreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(6);
        make.top.equalTo(backView).offset(6);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    scoreLabel = [[UILabel alloc] init];
    scoreLabel.text = @"";
    scoreLabel.font = [UIFont systemFontOfSize:16];
    [backView addSubview:scoreLabel];
    
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scoreImage.mas_right).offset(4);
        make.top.equalTo(backView).offset(6);
        make.size.mas_equalTo(CGSizeMake(120, 32));
    }];
    
    playNumberLabel = [[UILabel alloc] init];
    playNumberLabel.text = @"";
    playNumberLabel.textAlignment = NSTextAlignmentRight;
    playNumberLabel.font = [UIFont systemFontOfSize:16];
    [backView addSubview:playNumberLabel];
    
    [playNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.top.equalTo(backView).offset(6);
        make.size.mas_equalTo(CGSizeMake(100, 32));
    }];
    
    playNumberImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playnumber"]];
    [backView addSubview:playNumberImage];
    
    [playNumberImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(playNumberLabel.mas_left).offset(4);
        make.top.equalTo(backView).offset(6);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    contentBackView = [[UIView alloc] init];
    contentBackView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:contentBackView];
    
    [contentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myScrollView);
        make.top.equalTo(backView.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 108));
    }];
    
    contentTitleLabel = [[UILabel alloc] init];
    contentTitleLabel.text = @"内科主治医师考试辅导";
    contentTitleLabel.font = [UIFont systemFontOfSize:20.0];
    [contentBackView addSubview:contentTitleLabel];
    
    [contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentBackView).offset(18);
        make.top.equalTo(contentBackView).offset(18);
        make.size.mas_equalTo(CGSizeMake(280, 20));
    }];
    
    hideExpandButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [hideExpandButton setTitle:@"显示全部" forState:UIControlStateNormal];
    [hideExpandButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [contentBackView addSubview:hideExpandButton];
    
    [hideExpandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentBackView).offset(-16);
        make.top.equalTo(contentBackView).offset(18);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    contentTextView = [[UITextView alloc] init];
    contentTextView.editable = NO;
    contentTextView.text = @"卫生专业技术资格考试内科主治医师的基础知识、相关专业知识、专业知识和专业实践能力4个科目将全面复习巩固。";
    contentTextView.font = [UIFont systemFontOfSize:12];
    [contentBackView addSubview:contentTextView];
    
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentBackView).offset(18);
        make.right.equalTo(contentBackView).offset(-16);
        make.top.equalTo(contentTitleLabel.mas_bottom).offset(14);
        make.bottom.equalTo(contentBackView).offset(-18);
        
    }];
    
    headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myScrollView);
        make.top.equalTo(contentBackView.mas_bottom).offset(13);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 42));
    }];
    
    UIImageView *relatedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"relatedimage"]];
    [headerView addSubview:relatedImage];
    
    [relatedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(6);
        make.top.equalTo(headerView).offset(6);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    UILabel *relatedLabel = [[UILabel alloc] init];
    relatedLabel.text = @"相关视频";
    relatedLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:relatedLabel];
    
    [relatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(relatedImage.mas_right).offset(4);
        make.top.equalTo(headerView).offset(6);
        make.size.mas_equalTo(CGSizeMake(120, 32));
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc ]init];
    relatedMovieView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 62.0 * SCREEN_WIDTH/414.0 + 15.0, SCREEN_WIDTH, 326.0 * SCREEN_WIDTH/414.0) collectionViewLayout:flowLayout];
    relatedMovieView.backgroundColor = [UIColor whiteColor];
    relatedMovieView.dataSource = self;
    relatedMovieView.delegate = self;
    [relatedMovieView registerClass:[RelatedCollectionViewCell class] forCellWithReuseIdentifier:@"relatedCell"];
    [myScrollView addSubview:relatedMovieView];
    
    [relatedMovieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myScrollView);
        make.top.equalTo(headerView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 326.0 * SCREEN_WIDTH/414.0));
    }];
    
    pageNo = 1;
    self.relatedArray = [[NSMutableArray alloc] init];
    CourseMovieListService *relatedService = [[CourseMovieListService alloc] init];
    relatedService.delegate = self;
    [relatedService getCourseMovieList:[self.subject_id stringValue] orderType:@"1" recommend:@"" pageNo:pageNo pageSize:PAGESIZE];
    
    moreMovie = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreMovie setTitle:@"更多相关视频..." forState:UIControlStateNormal];
    [moreMovie setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [moreMovie setBackgroundColor:[UIColor whiteColor]];
    [moreMovie addTarget:self action:@selector(getMoreMovie:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:moreMovie];
    
    [moreMovie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myScrollView);
        make.top.equalTo(relatedMovieView.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 42));
    }];
}

- (void)getMoreMovie:(id)sender {
    pageNo++;
    CourseMovieListService *relatedService = [[CourseMovieListService alloc] init];
    relatedService.delegate = self;
    [relatedService getCourseMovieList:[self.subject_id stringValue] orderType:@"1" recommend:@"" pageNo:pageNo pageSize:PAGESIZE];
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.relatedArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RelatedCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"relatedCell" forIndexPath:indexPath];
    
    [cell setText:[self.relatedArray objectAtIndex:indexPath.row]];
    
    //    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/2.0 - 9.0, 152.0 * SCREEN_WIDTH/414.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0);
}

#pragma mark- DZVideoPlayerViewControllerDelegate

- (void)playerDidPlay {
    
}

- (void)playerDidToggleFullscreen {
    if (!self.videoPlayerViewController.isFullscreen) {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationPortrait;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
        
        [self.videoPlayerViewControllerContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(64);
            make.height.equalTo(self.videoPlayerViewControllerContainerView.mas_width).multipliedBy(235.0/360.0);
        }];
    } else {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationLandscapeRight;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
        
        [self.videoPlayerViewControllerContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
}

#pragma mark - Coure movie list delegate

- (void)returnCourseMovieList:(NSArray *)dataArray Tag:(int)tag {
    if (dataArray && [dataArray count] != 0) {
        [self.relatedArray addObjectsFromArray:dataArray];
        [relatedMovieView reloadData];
        
        myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 520 + 326.0 * SCREEN_WIDTH/414.0 * pageNo);
        
        [relatedMovieView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myScrollView);
            make.top.equalTo(headerView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 326.0 * SCREEN_WIDTH/414.0 * pageNo));
        }];
    }
}

- (void)relogin {
//    [self.delegate relogin];
}

@end
