//
//  IndexViewController.m
//  MedicalTech
//
//  Created by Jason on 7/1/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "IndexViewController.h"
#import "HMSegmentedControl.h"

#define VIEWWIDTH self.view.frame.size.width
#define VIEWHEIGHT self.view.frame.size.height

@interface IndexViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UITableView *platformTableView;
@property (nonatomic, strong) UICollectionView *studyCollectionView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"医教平台", @"在线学习", @"病例学习", @"模拟考试"]];
    self.segmentedControl.frame = CGRectMake(0, 64, VIEWWIDTH, 41);
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
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 105.0, VIEWWIDTH, VIEWHEIGHT - 105.0)];
    self.myScrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.contentSize = CGSizeMake(VIEWWIDTH * 4, VIEWHEIGHT - 105.0);
    self.myScrollView.delegate = self;
    [self.myScrollView scrollRectToVisible:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT - 105.0) animated:NO];
    [self.view addSubview:self.myScrollView];
    
    self.platformTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, VIEWWIDTH, VIEWHEIGHT - 105.0)];
    [self.myScrollView addSubview:self.platformTableView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc ]init];
    self.studyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(VIEWWIDTH, 0.0, VIEWWIDTH, VIEWHEIGHT - 105.0) collectionViewLayout:flowLayout];
    self.studyCollectionView.backgroundColor = [UIColor yellowColor];
    [self.myScrollView addSubview:self.studyCollectionView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(VIEWWIDTH * 2, 0.0, VIEWWIDTH, VIEWHEIGHT - 105.0)];
    label.text = @"敬请期待";
    label.backgroundColor = [UIColor blueColor];
    [self.myScrollView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(VIEWWIDTH * 3, 0.0, VIEWWIDTH, VIEWHEIGHT - 105.0)];
    label2.text = @"敬请期待";
    label2.backgroundColor = [UIColor greenColor];
    [self.myScrollView addSubview:label2];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

@end
