//
//  IndexViewController.m
//  MedicalTech
//
//  Created by Jason on 7/1/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "IndexViewController.h"
#import "HMSegmentedControl.h"
#import "KNBannerView.h"
#import "PlatformTableViewCell.h"
#import "StudyCollectionViewCell.h"
#import "MyCourseViewController.h"
#import "SubjectViewController.h"
#import "AdvService.h"
#import "CourseMovieListService.h"
#import "PlayerViewController.h"
#import "DictInfoService.h"
#import "UserInfoService.h"

@interface IndexViewController () <UIScrollViewDelegate, UITableViewDelegate,
    UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
    UIGestureRecognizerDelegate, AdvServiceDelegate, CourseMovieListServiceDelegate, DictInfoServiceDelegate, UserInfoServiceDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) KNBannerView *myBannerView;
@property (nonatomic, strong) UITableView *platformTableView;
@property (nonatomic, strong) UICollectionView *studyCollectionView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *platformArray;
@property (nonatomic, strong) NSArray *studyArray;
@property (nonatomic, strong) SubjectViewController *subjectViewController;
@property (nonatomic, strong) MyCourseViewController *myCourseViewController;
@property (nonatomic, strong) PlayerViewController *playerViewController;
@property (nonatomic, strong) UIWebView *trainWebView;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *trainUrl;

@end

@implementation IndexViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"医学移动教育平台";
    
    [self initUI];
}

- (void)initUI {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"peopleicon"] style:UIBarButtonItemStylePlain target:self action:@selector(peopleIconButton:)];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"医教平台", @"在线学习", @"规范化培训", @"模拟考试"]];
    
    self.segmentedControl.frame = CGRectMake(0, 64, SCREEN_WIDTH, 41);
    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:30.0/255.0 green:198.0/255.0 blue:180.0/255.0 alpha:1.0];
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.segmentedControl.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"ArialMT" size:16.0]};
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.myScrollView scrollRectToVisible:CGRectMake(weakSelf.view.frame.size.width * index, 0, weakSelf.view.frame.size.width, 200) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 105.0, SCREEN_WIDTH, SCREEN_HEIGHT - 105.0)];
    self.myScrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT - 105.0);
    self.myScrollView.delegate = self;
    [self.myScrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 105.0) animated:NO];
    self.myScrollView.scrollEnabled = NO;
    [self.view addSubview:self.myScrollView];
    
    // 设置 网络 轮播图
    NSArray *imgArr = @[@"test1", @"test1"];
    self.myBannerView = [KNBannerView bannerViewWithLocationImagesArr:imgArr frame:CGRectMake(0, 0.0, SCREEN_WIDTH, SCREEN_WIDTH/2.0)];
    self.myBannerView.pageControlStyle = KNPageControlStyleMiddle;
    self.myBannerView.placeHolder = @"3";
    [AdvService sharedInstance].delegate = self;
    [[AdvService sharedInstance] getAdvList:@"23"];
    [self.myScrollView addSubview:self.myBannerView];
    
    self.platformTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, SCREEN_WIDTH/2.0, SCREEN_WIDTH, SCREEN_HEIGHT -SCREEN_WIDTH/2.0 - 105.0)];
    self.platformTableView.delegate = self;
    self.platformTableView.dataSource = self;
    [self.myScrollView addSubview:self.platformTableView];
    
    UIView *studyHeaderView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 1.0, SCREEN_WIDTH, 60.0 * SCREEN_WIDTH/414.0)];
    studyHeaderView.backgroundColor = [UIColor whiteColor];
    UIImageView *studyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(6.0, 15.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0)];
    studyIcon.image = [UIImage imageNamed:@"studyIcon"];
    UILabel *studyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0 * SCREEN_WIDTH/414.0, 15.0 * SCREEN_WIDTH/414.0, 280.0, 32.0 * SCREEN_WIDTH/414.0)];
    studyTitleLabel.text = @"我院学习资料";
    [studyHeaderView addSubview:studyIcon];
    [studyHeaderView addSubview:studyTitleLabel];
    [self.myScrollView addSubview:studyHeaderView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc ]init];
    self.studyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 62.0 * SCREEN_WIDTH/414.0 + 1.0, SCREEN_WIDTH, 475.0 * SCREEN_WIDTH/414.0) collectionViewLayout:flowLayout];
    self.studyCollectionView.backgroundColor = [UIColor whiteColor];
    self.studyCollectionView.dataSource = self;
    self.studyCollectionView.delegate = self;
    [self.studyCollectionView registerClass:[StudyCollectionViewCell class] forCellWithReuseIdentifier:@"studyCell"];
    [self.myScrollView addSubview:self.studyCollectionView];
    
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 537.0 * SCREEN_WIDTH/414.0, SCREEN_WIDTH, 1.0)];
    splitView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:192.0/255.0 blue:179.0/255.0 alpha:1.0];
    [self.myScrollView addSubview:splitView];
    
    UIButton *myLessonButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 537.0 * SCREEN_WIDTH/414.0 + 1.0, SCREEN_WIDTH/2.0, 41.0)];
    [myLessonButton setImage:[UIImage imageNamed:@"mylesson"] forState:UIControlStateNormal];
    
    if (SCREEN_WIDTH == 375.0) {
        [myLessonButton setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, -90)];
    } else if (SCREEN_WIDTH == 320.0) {
        [myLessonButton setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, -90)];
    } else {
        [myLessonButton setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, -80)];
    }
    
    [myLessonButton setTitle:@"我的课程" forState:UIControlStateNormal];
    [myLessonButton setTitleColor:[UIColor colorWithRed:0.0/255.0 green:192.0/255.0 blue:179.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [myLessonButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 30)];
    myLessonButton.backgroundColor = [UIColor whiteColor];
    [myLessonButton addTarget:self action:@selector(goToMyCourse:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:myLessonButton];
    
    UIButton *moreLessonButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH + SCREEN_WIDTH/2.0, 537.0 * SCREEN_WIDTH/414.0 + 1.0, SCREEN_WIDTH/2.0, 41.0)];
    [moreLessonButton setImage:[UIImage imageNamed:@"morelesson"] forState:UIControlStateNormal];
    if (SCREEN_WIDTH == 375.0) {
        [moreLessonButton setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, -90)];
    } else if (SCREEN_WIDTH == 320.0) {
        [moreLessonButton setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, -90)];
    } else {
        [moreLessonButton setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, -80)];
    }
    
    [moreLessonButton setTitle:@"更多课程" forState:UIControlStateNormal];
    [moreLessonButton setTitleColor:[UIColor colorWithRed:0.0/255.0 green:192.0/255.0 blue:179.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [moreLessonButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 30)];
    moreLessonButton.backgroundColor = [UIColor whiteColor];
    [moreLessonButton addTarget:self action:@selector(goToSubjectView:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:moreLessonButton];
    
    self.trainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - 105.0)];
    [self.myScrollView addSubview:self.trainWebView];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - 105.0)];
    [self.myScrollView addSubview:view2];
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lookingforward"]];
    [view2 addSubview:imageview2];
    
    [imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view2);
        make.size.mas_equalTo(CGSizeMake(128, 128));
    }];
}

- (void)loadData {
    CourseMovieListService *recommendService = [[CourseMovieListService alloc] init];
    recommendService.tag = 1;
    recommendService.delegate = self;
    [recommendService getCourseMovieList:@"" orderType:@""
                               recommend:@"1"   pageNo:1
                                pageSize:10];
    
    CourseMovieListService *latestService = [[CourseMovieListService alloc] init];
    latestService.tag = 2;
    latestService.delegate = self;
    [latestService getCourseMovieList:@"" orderType:@"1"
                            recommend:@""   pageNo:1
                             pageSize:6];
    
    DictInfoService *dictInfoService = [[DictInfoService alloc] init];
    dictInfoService.delegate = self;
    [dictInfoService getDictInfo];
    
    UserInfoService *userInfoService = [[UserInfoService alloc] init];
    userInfoService.delegate = self;
    [userInfoService getUserInfo];
}

- (void)peopleIconButton:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)goToMyCourse:(id)sender {
    if (self.myCourseViewController) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        [self.navigationController pushViewController:self.myCourseViewController animated:YES];
    } else {
        self.myCourseViewController = [[MyCourseViewController alloc] init];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        [self.navigationController pushViewController:self.myCourseViewController animated:YES];
    }
}

- (void)goToSubjectView:(id)sender {
    if (self.subjectViewController) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        [self.navigationController pushViewController:self.subjectViewController animated:YES];
    } else {
        self.subjectViewController = [[SubjectViewController alloc] init];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        [self.navigationController pushViewController:self.subjectViewController animated:YES];
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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 59.0 * SCREEN_WIDTH/414.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 331.0 * SCREEN_WIDTH/414.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 59.0 * SCREEN_WIDTH/414.0)];
            headerView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0 * SCREEN_WIDTH/414.0, 13.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0)];
            [imageView setImage:[UIImage imageNamed:@"playIcon"]];
            [headerView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42.0 * SCREEN_WIDTH/414.0, 13.0 * SCREEN_WIDTH/414.0, 200.0, 32.0 * SCREEN_WIDTH/414.0)];
            titleLabel.text = @"在线学习精选";
            titleLabel.backgroundColor = [UIColor clearColor];
            [headerView addSubview:titleLabel];
            
            return headerView;
            break;
        }
        case 1:
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 59.0 * SCREEN_WIDTH/414.0)];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0 * SCREEN_WIDTH/414.0, 13.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0)];
            [imageView setImage:[UIImage imageNamed:@"exampleIcon"]];
            [headerView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42.0 * SCREEN_WIDTH/414.0, 13.0 * SCREEN_WIDTH/414.0, 200.0, 32.0 * SCREEN_WIDTH/414.0)];
            titleLabel.text = @"病例学习精选";
            titleLabel.backgroundColor = [UIColor clearColor];
            [headerView addSubview:titleLabel];
            
            return headerView;
            break;
        }
        case 2:
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 59.0 * SCREEN_WIDTH/414.0)];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0 * SCREEN_WIDTH/414.0, 13.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0, 32.0 * SCREEN_WIDTH/414.0)];
            [imageView setImage:[UIImage imageNamed:@"testIcon"]];
            [headerView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42.0 * SCREEN_WIDTH/414.0, 13.0 * SCREEN_WIDTH/414.0, 200.0, 32.0 * SCREEN_WIDTH/414.0)];
            titleLabel.text = @"模拟考试精选";
            titleLabel.backgroundColor = [UIColor clearColor];
            [headerView addSubview:titleLabel];
            
            return headerView;
            break;
        }
        default:
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 59.0 * SCREEN_WIDTH/414.0)];
            
            return headerView;
            break;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [self.platformArray objectAtIndex:indexPath.row];
  
    if (self.playerViewController) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        self.playerViewController.exam_id = [dictionary objectForKey:@"exam_id"];
        self.playerViewController.subject_id = [dictionary objectForKey:@"subject_id"];
        [self.navigationController pushViewController:self.playerViewController animated:YES];
    } else {
        self.playerViewController = [[PlayerViewController alloc] init];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        self.playerViewController.exam_id = [dictionary objectForKey:@"exam_id"];
        self.playerViewController.subject_id = [dictionary objectForKey:@"subject_id"];
        [self.navigationController pushViewController:self.playerViewController animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.platformArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Platform"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[PlatformTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Platform"];
        cell.separatorInset = UIEdgeInsetsZero;
    }

    [cell setText:[self.platformArray objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StudyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"studyCell" forIndexPath:indexPath];
    
    [cell setText:[self.studyArray objectAtIndex:indexPath.row]];
    
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/2.0 - 9.0, 148.0 * SCREEN_WIDTH/414.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(3.0, 3.0, 0.0, 3.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [self.studyArray objectAtIndex:indexPath.row];
    
    if (self.playerViewController) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        self.playerViewController.exam_id = [dictionary objectForKey:@"exam_id"];
        self.playerViewController.subject_id = [dictionary objectForKey:@"subject_id"];
        [self.navigationController pushViewController:self.playerViewController animated:YES];
    } else {
        self.playerViewController = [[PlayerViewController alloc] init];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        self.playerViewController.exam_id = [dictionary objectForKey:@"exam_id"];
        self.playerViewController.subject_id = [dictionary objectForKey:@"subject_id"];
        [self.navigationController pushViewController:self.playerViewController animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

#pragma mark - AdvService delegate

- (void)returnAdvList:(NSArray *)dataArray {
    NSMutableArray *imgArr = [NSMutableArray array];
    for (NSDictionary *imgDictionary in dataArray) {
        [imgArr addObject:[imgDictionary objectForKey:@"img"]];
    }
    self.myBannerView.netWorkImgArr = imgArr;
}

#pragma mark - Course movie list delegate

- (void)returnCourseMovieList:(NSArray *)dataArray Tag:(int)tag {
    NSLog(@"%@", dataArray);
    switch (tag) {
        case 1:
        {
            self.platformArray = dataArray;
            [self.platformTableView reloadData];
            break;
        }
        case 2:
        {
            self.studyArray = dataArray;
            [self.studyCollectionView reloadData];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Dict info service delegate

- (void)returnDictInfo:(NSArray *)dataArray {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for (NSDictionary *data in dataArray) {
        if ([[data objectForKey:@"dicCode"] isEqualToString:@"1"]) {
            self.trainUrl = [data objectForKey:@"dicValue"];
        } else if ([[data objectForKey:@"dicCode"] isEqualToString:@"2"]) {
            [defaults setValue:[data objectForKey:@"dicValue"] forKey:@"helpURL"];
        }
    }
    
    if (self.userId) {
        self.trainUrl = [NSString stringWithFormat:@"%@%@", self.trainUrl, self.userId];
        NSLog(@"url: %@", self.trainUrl);
        [self.trainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.trainUrl]]];
    }
}

#pragma mark - UserInfoService delegate

- (void)returnUserInfo:(NSDictionary *)data {
    self.userId = [data objectForKey:@"userId"];
    
    if (self.trainUrl) {
        self.trainUrl = [NSString stringWithFormat:@"%@%@", self.trainUrl, self.userId];
        NSLog(@"url: %@", self.trainUrl);
        [self.trainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.trainUrl]]];
    }
    
}

@end
