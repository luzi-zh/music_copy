//
//  ManYou.m
//  网易云仿写
//
//  Created by luzi on 2026/5/17.
//

#import "ManYou.h"
#import "cover.h"
#import "Setting.h"
#import "Masonry/Masonry.h"
@interface ManYou ()
@property(nonatomic,copy)NSArray* arrI;
@property(nonatomic,copy)NSArray* arrL;
@property(nonatomic,strong)UISearchBar* searchBar;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, retain) NSTimer* timerView;
@property (nonatomic, strong) NSArray *originArr;
@property (nonatomic, strong) NSMutableArray *loopArr;
@property (nonatomic, assign) CGFloat pageW;

@property (nonatomic, strong) NSTimer* loopTimer;

@property (nonatomic, strong) UIPageControl* pageControl;
@end

@implementation ManYou

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.originArr = @[@"1",@"2",@"3",@"4",@"5"];
    self.pageW = self.view.bounds.size.width-40;
    
    self.loopArr = [NSMutableArray array];
    [self.loopArr addObject:self.originArr.lastObject]; // 头哑页
    [self.loopArr addObjectsFromArray:self.originArr];
    [self.loopArr addObject:self.originArr.firstObject];// 尾哑页
    
    UIScrollView *sv = [[UIScrollView alloc]init];
    sv.pagingEnabled = YES;
    sv.delegate = self;
    //sv.showsHorizontalScrollIndicator = YES;
    sv.showsVerticalScrollIndicator = NO;
    sv.contentSize = CGSizeMake(self.pageW * self.loopArr.count, 200);
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(40);
        make.left.equalTo(self.view).offset(20);
        make.width.mas_equalTo(self.pageW);
        make.height.equalTo(@200);
    }];
    self.scrollView = sv;
    
    for (int i = 0; i < self.loopArr.count; i++) {
        UIImageView *iv = [[UIImageView alloc]init];
        iv.image = [UIImage imageNamed:self.loopArr[i]];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = YES;
        iv.layer.cornerRadius = 10;
        [sv addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*self.pageW);
            make.top.equalTo(@0);
            make.width.mas_equalTo(self.pageW);
            make.height.equalTo(@200);
        }];
    }
    sv.contentOffset = CGPointMake(self.pageW, 0);
    
    [self startLoopTimer];
    
    self.pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sv);
        make.bottom.equalTo(sv.mas_bottom).offset(-10);
        make.width.equalTo(@150);
        make.height.equalTo(@10);
    }];
    self.pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    
    
    
    
    
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(170, 170);
    layout.minimumLineSpacing = 40;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[cover class] forCellWithReuseIdentifier:@"covercell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    _arrI = @[@"ch",@"lo",@"ji",@"hot",@"we",@"say"];
    _arrL = @[@"华语",@"情歌",@"经典",@"热歌榜",@"欧美",@"说唱"];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sv.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.equalTo(@500);
    }];
    
    
    
}

-(void)startLoopTimer
{
    if(_loopTimer){
            [_loopTimer invalidate];
            _loopTimer = nil;
        }
        self.loopTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            CGFloat offsetX = self.scrollView.contentOffset.x;
            NSInteger currentPage = offsetX / self.pageW;

            // 下一页
            NSInteger nextPage = currentPage + 1;

            if (currentPage == self.loopArr.count - 2) {
                // 最后一张占位图 → 瞬间跳转到第1张真实图
                self.scrollView.contentOffset = CGPointMake(self.pageW, 0);
                self.pageControl.currentPage = 0; // 页码重置为0
            } else {
                // 正常滚动
                self.scrollView.contentOffset = CGPointMake(nextPage * self.pageW, 0);
                self.pageControl.currentPage = nextPage - 1; // 正确页码
            }
        }];
}

-(void)stopLoopTimer
{
    if(_loopTimer){
        [_loopTimer invalidate];
        _loopTimer = nil;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView != self.scrollView) return;
    [self stopLoopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView != self.scrollView) return;
    [self startLoopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if(scrollView != self.scrollView) return;

    NSInteger idx = scrollView.contentOffset.x / self.pageW;
        
    // 滑到最后哑页 → 跳回第1张真实
    if (idx == self.loopArr.count - 1) {
        scrollView.contentOffset = CGPointMake(self.pageW, 0);
        idx = 1;
    }
    // 滑到最前哑页 → 跳回最后一张真实
    else if (idx == 0) {
        scrollView.contentOffset = CGPointMake(self.pageW * (self.loopArr.count - 2), 0);
        idx = self.loopArr.count - 2;
    }
    self.pageControl.currentPage = idx - 1;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cover* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"covercell" forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:_arrI[indexPath.row]];
    cell.lab.text = _arrL[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 整个屏幕宽度
    CGFloat screenWidth = self.view.bounds.size.width;
    
    // 左右间距 + 中间间距
    CGFloat paddingLeft = 15;    // 左边距
    CGFloat paddingRight = 15;   // 右边距
    CGFloat space = 10;          // 两个 cell 中间的间距
    
    // 计算每个 cell 的宽度
    CGFloat width = (screenWidth - paddingLeft - paddingRight - space) / 2.0;
    
    // 高度自己定
    CGFloat height = width;
    
    return CGSizeMake(width, height);
}

-(void)tanchu
{
    Setting *set = [[Setting alloc] init];
    [set show];
}
- (void)hideKeyboard {
    [self.searchBar resignFirstResponder];
    //[self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
