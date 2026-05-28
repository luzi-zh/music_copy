//
//  ManYou.m
//  网易云仿写
//
//  Created by luzi on 2026/5/17.
//

#import "ManYou.h"
#import "cover.h"
#import "Setting.h"
@interface ManYou ()
@property(nonatomic,copy)NSArray* arrI;
@property(nonatomic,copy)NSArray* arrL;
@property(nonatomic,strong)UISearchBar* searchBar;
@end

@implementation ManYou

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(170, 170);
    layout.minimumLineSpacing = 40;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[cover class] forCellWithReuseIdentifier:@"covercell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    _arrI = @[@"ch",@"lo",@"ji",@"hot",@"we",@"say"];
    _arrL = @[@"华语",@"情歌",@"经典",@"热歌榜",@"欧美",@"说唱"];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.shadowImage = nil;
    
    UIView* searchc = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 250, 35))];
    //搜索框
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"林俊杰";
    self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.frame = searchc.bounds;
    self.searchBar.delegate = self;
    [self.searchBar setReturnKeyType:UIReturnKeySearch];
    [searchc addSubview:self.searchBar];
    self.navigationItem.titleView = searchc;
    //左三
    UIBarButtonItem* tan = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"line.horizontal.3"] style:UIBarButtonItemStylePlain target:self action:@selector(tanchu)];
    self.navigationItem.leftBarButtonItem = tan;
    //右听歌识曲
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 35);
    UIImage* sing = [UIImage imageNamed:@"sing"];
    [rightBtn setImage:sing forState:UIControlStateNormal];
    // 添加点击事件
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //转为导航栏按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
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
