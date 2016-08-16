//
//  SubjectViewController.m
//  MedicalTech
//
//  Created by Jason on 7/15/16.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "SubjectViewController.h"
#import "HMSegmentedControl.h"
#import "TitleCollectionViewCell.h"
#import "ContentCollectionViewCell.h"
#import "PlayerViewController.h"

@interface SubjectViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *expandButton;
@property (nonatomic, strong) HMSegmentedControl *titleSegmentedControl;
@property (nonatomic, strong) UICollectionView *titleCollectionView;
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSArray *catalogArray;
@property (nonatomic, strong) NSArray *currentArray;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign) NSUInteger currentLevel;
@property (nonatomic, assign) NSUInteger preIndex;
@property (nonatomic, assign) NSUInteger preLevel;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *subjectIdArray;
@property (nonatomic, strong) NSMutableArray *historyTable;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, assign) BOOL isExpand;
@property (nonatomic, strong) PlayerViewController *playerViewController;

@end

@implementation SubjectViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.playerViewController = nil;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:CATALOGTREE parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        self.catalogArray = [dictionary objectForKey:@"data"];
        self.currentArray = self.catalogArray;
        NSLog(@"%@", self.catalogArray);
        [self.titleArray removeAllObjects];
        [self.subjectIdArray removeAllObjects];
        for (NSDictionary *dictionary in self.currentArray) {
            [self.titleArray addObject:[dictionary objectForKey:@"name"]];
            [self.subjectIdArray addObject:[dictionary objectForKey:@"subjectId"]];
        }
        
        [self.titleSegmentedControl setSectionTitles:self.titleArray];
        [self.titleCollectionView reloadData];
        [self getContentList:[self.subjectIdArray objectAtIndex:0]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"医学移动教育平台";
    self.view.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0];
    
    self.titleArray = [[NSMutableArray alloc] init];
    self.subjectIdArray = [[NSMutableArray alloc] init];
    self.historyTable = [[NSMutableArray alloc] init];
    self.isExpand = NO;

    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backButton.enabled = NO;
    [self.backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    self.backButton.backgroundColor = [UIColor whiteColor];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0)];
    self.backButton.tintColor = [UIColor colorWithRed:5.0/255.0 green:190.0/255.0 blue:187.0/255.0 alpha:1.0];
    [self.backButton addTarget:self action:@selector(goToPreTitle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton.superview);
        make.top.equalTo(self.backButton.superview).offset(64.0);
        make.size.mas_equalTo(CGSizeMake(44.0, 44.0));
    }];
    
    self.expandButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.expandButton setImage:[UIImage imageNamed:@"expandbutton"] forState:UIControlStateNormal];
    self.expandButton.backgroundColor = [UIColor whiteColor];
    [self.expandButton setImageEdgeInsets:UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0)];
    self.expandButton.tintColor = [UIColor colorWithRed:5.0/255.0 green:190.0/255.0 blue:187.0/255.0 alpha:1.0];
    [self.expandButton addTarget:self action:@selector(expandTitleView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.expandButton];
    
    [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.expandButton.superview);
        make.top.equalTo(self.expandButton.superview).offset(64.0);
        make.size.mas_equalTo(CGSizeMake(44.0, 44.0));
    }];
    
    self.titleSegmentedControl = [[HMSegmentedControl alloc] init];
    self.titleSegmentedControl.type = HMSegmentedControlTypeText;
    self.titleSegmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    self.titleSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.titleSegmentedControl.selectionIndicatorColor = [UIColor colorWithRed:30.0/255.0 green:198.0/255.0 blue:180.0/255.0 alpha:1.0];
    self.titleSegmentedControl.selectionIndicatorHeight = 0.0f;
    self.titleSegmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.titleSegmentedControl.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0 weight:UIFontWeightThin], NSForegroundColorAttributeName: [UIColor colorWithRed:30.0/255.0 green:198.0/255.0 blue:180.0/255.0 alpha:1.0]};
    __weak typeof(self) weakSelf = self;
    [self.titleSegmentedControl setIndexTouchBlock:^(NSInteger index) {
        [weakSelf getContentList:[weakSelf.subjectIdArray objectAtIndex:index]];
        
        NSDictionary *dictionary = [weakSelf.currentArray objectAtIndex:index];
        NSArray *childsList = [dictionary objectForKey:@"childsList"];
        
        if (childsList && childsList.count != 0) {
            weakSelf.currentArray = childsList;
            [weakSelf.titleArray removeAllObjects];
            for (NSDictionary *childDictionary in weakSelf.currentArray) {
                [weakSelf.titleArray addObject:[childDictionary objectForKey:@"name"]];
                [weakSelf.subjectIdArray addObject:[childDictionary objectForKey:@"subjectId"]];
            }
            [weakSelf.titleSegmentedControl setSectionTitles:weakSelf.titleArray];
            [weakSelf.titleCollectionView reloadData];
            
            weakSelf.currentIndex = index;
            
            [weakSelf.historyTable addObject:@{@"level": @(weakSelf.currentLevel), @"index": @(weakSelf.currentIndex)}];
            weakSelf.currentLevel++;
            weakSelf.backButton.enabled = YES;
        } else {
            NSLog(@"当前已是最底层");
        }
    }];
    
    [self.view addSubview:self.titleSegmentedControl];
    
    [self.titleSegmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton.mas_right);
        make.top.equalTo(self.titleSegmentedControl.superview).offset(64);
        make.right.equalTo(self.expandButton.mas_left);
        make.height.mas_equalTo(44);
    }];
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc ]init];
    self.contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120.0, SCREEN_WIDTH, SCREEN_HEIGHT - 160.0) collectionViewLayout:flowLayout2];
    self.contentCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentCollectionView registerClass:[ContentCollectionViewCell class] forCellWithReuseIdentifier:@"contentCell"];
    self.contentCollectionView.delegate = self;
    self.contentCollectionView.dataSource = self;
    self.contentCollectionView.tag = 2;
    [self.view addSubview:self.contentCollectionView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc ]init];
    self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 108.0, SCREEN_WIDTH, 0.0) collectionViewLayout:flowLayout];
    self.titleCollectionView.backgroundColor = [UIColor whiteColor];
    self.titleCollectionView.layer.borderWidth = 1.0f;
    self.titleCollectionView.layer.borderColor = [UIColor colorWithRed:30.0/255.0 green:198.0/255.0 blue:180.0/255.0 alpha:1.0].CGColor;
    [self.titleCollectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"titleCell"];
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    self.titleCollectionView.tag = 1;
    [self.view addSubview:self.titleCollectionView];
}

- (void)getContentList:(NSNumber *)subjectId {
    [MBProgressHUD showHUDAddedTo:self.contentCollectionView animated:YES].dimBackground = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:HEADERTOKEN forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[NSString stringWithFormat:@"%@%@___1_20.do", CATALOGVIDEOLIST, subjectId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        self.contentArray = [dictionary objectForKey:@"data"];
        [self.contentCollectionView reloadData];
        [MBProgressHUD hideHUDForView:self.contentCollectionView animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.contentCollectionView animated:YES];
    }];
}

- (void)goToIndex:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goToPreTitle:(id)sender {
    NSDictionary *preDictionary = [self.historyTable lastObject];
    NSUInteger level = [[preDictionary objectForKey:@"level"] integerValue];
    NSUInteger index = [[preDictionary objectForKey:@"index"] integerValue];
    
    if (level == 0) {
        [self.titleArray removeAllObjects];
        [self.subjectIdArray removeAllObjects];
        self.currentArray = self.catalogArray;
        for (NSDictionary *dictionary in self.catalogArray) {
            [self.titleArray addObject:[dictionary objectForKey:@"name"]];
            [self.subjectIdArray addObject:[dictionary objectForKey:@"subjectId"]];
        }
        [self.titleSegmentedControl setSectionTitles:self.titleArray];
        [self.titleCollectionView reloadData];
        
        NSNumber *subjectId = [self.subjectIdArray objectAtIndex:index];
        [self getContentList:subjectId];
        
        [self.historyTable removeLastObject];
        self.currentLevel = level;
        self.backButton.enabled = NO;
    } else {
        NSArray *tempArray = self.catalogArray;
        NSLog(@"%lu", (unsigned long)self.historyTable.count);
        for (int i = 0; i < self.historyTable.count - 1; i++) {
            NSDictionary *preHistoryDictionary = [self.historyTable objectAtIndex:i];
            NSUInteger tempIndex = [[preHistoryDictionary objectForKey:@"index"] integerValue];
            
            NSDictionary *preDictionary = [tempArray objectAtIndex:tempIndex];
            tempArray = [preDictionary objectForKey:@"childsList"];
        }
        [self.titleArray removeAllObjects];
        [self.subjectIdArray removeAllObjects];
        self.currentArray = tempArray;
        for (NSDictionary *dictionary in tempArray) {
            [self.titleArray addObject:[dictionary objectForKey:@"name"]];
            [self.subjectIdArray addObject:[dictionary objectForKey:@"subjectId"]];
        }
        [self.titleSegmentedControl setSectionTitles:self.titleArray];
        [self.titleCollectionView reloadData];
        
        
        NSNumber *subjectId = [self.subjectIdArray objectAtIndex:index];
        [self getContentList:subjectId];
        
        [self.historyTable removeLastObject];
        self.currentLevel = level;
    }
}

- (void)expandTitleView:(id)sender {
    if (self.isExpand) {
        [UIView beginAnimations:@"titleCollectionViewExpand" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:0.5];
        [self.titleCollectionView setFrame:CGRectMake(0.0, 108.0, SCREEN_WIDTH, 0)];
        [UIView commitAnimations];
        
        [self.expandButton setImage:[UIImage imageNamed:@"expandbutton"] forState:UIControlStateNormal];
        self.isExpand = NO;
    } else {
        [UIView beginAnimations:@"titleCollectionViewExpand" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:0.5];
        [self.titleCollectionView setFrame:CGRectMake(0.0, 108.0, SCREEN_WIDTH, 260.0)];
        [UIView commitAnimations];
        
        [self.expandButton setImage:[UIImage imageNamed:@"expand2button"] forState:UIControlStateNormal];
        self.isExpand = YES;
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1) {
        return self.titleArray.count;
    } else {
        return self.contentArray.count;
    }
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1) {
        TitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        
        [cell setText:[self.titleArray objectAtIndex:indexPath.row]];
        
        //    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
        return cell;
    } else {
        ContentCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentCell" forIndexPath:indexPath];
        
        [cell setText:[self.contentArray objectAtIndex:indexPath.row]];
        
        //    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1) {
        NSDictionary *dictionary = [self.currentArray objectAtIndex:indexPath.row];
        NSArray *childsList = [dictionary objectForKey:@"childsList"];
        
        if (childsList && childsList.count != 0) {
            self.currentArray = childsList;
            [self.titleArray removeAllObjects];
            for (NSDictionary *childDictionary in self.currentArray) {
                [self.titleArray addObject:[childDictionary objectForKey:@"name"]];
            }
            [self.titleSegmentedControl setSectionTitles:self.titleArray];
            [self.titleCollectionView reloadData];
            
            self.currentIndex = indexPath.row;
            
            [self.historyTable addObject:@{@"level": @(self.currentLevel), @"index": @(self.currentIndex)}];
            self.currentLevel++;
            self.backButton.enabled = YES;
        } else {
            NSLog(@"当前已是最底层");
        }
    } else {
        NSDictionary *dictionary = [self.contentArray objectAtIndex:indexPath.row];
        if (self.playerViewController) {
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = barButtonItem;
            self.playerViewController.exam_id = [dictionary objectForKey:@"exam_id"];
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
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1) {
        return CGSizeMake(80.0, 24.0);
    } else {
        return CGSizeMake(SCREEN_WIDTH/3.0 - 10.0, 100.0);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 1) {
        return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    } else {
        return UIEdgeInsetsMake(5.0, 5.0, 0.0, 5.0);
    }
    
}

@end
