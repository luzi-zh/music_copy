//
//  MyController.m
//  网易云仿写
//
//  Created by luzi on 2026/5/31.
//

#import "MyController.h"
#import "MyCell.h"
#import "MyModel.h"
#import "MyHeader.h"
#import "Masonry/Masonry.h"
#import "Setting.h"

@interface MyController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITableView *tb;
@property(nonatomic,strong)MyHeader *headerView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *dataSource2;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UISegmentedControl *seg;
@property(nonatomic,assign)BOOL save;
@property(nonatomic,strong)UIScrollView* sc;
@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupMainUI];
    [self loadListData];
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
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addGestureRecognizer:tap];

    
}

-(void)rightBtnClick
{
    
}

- (void)hideKeyboard {
    [self.searchBar resignFirstResponder];
    //[self.view endEditing:YES];
}


-(void)tanchu
{
    Setting *set = [[Setting alloc] init];
    [set show];
}

- (void)setupMainUI {
    self.headerView = [[MyHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 320)];
//    self.headerView.backgroundColor = [UIColor colorWithRed:40/255.0 green:20/255.0 blue:15/255.0 alpha:1];
    self.headerView.parentVC = self;
    [self.view addSubview:_headerView];
    
    _sc = [[UIScrollView alloc] init];
    _sc.backgroundColor = [UIColor systemBackgroundColor];
    [self.view addSubview:_sc];
    _sc.pagingEnabled = YES;
    _sc.delegate = self;
    _sc.showsHorizontalScrollIndicator = YES;
    _sc.showsVerticalScrollIndicator = YES;
    _sc.contentSize = CGSizeMake(self.view.bounds.size.width*2, 500);
    [_sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom).offset(20);
        make.left.equalTo(@0);
        make.width.mas_equalTo(self.view.bounds.size.width);
        make.height.equalTo(@500);
    }];
    
    // 列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor systemBackgroundColor];
//    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerClass:[MyCell class] forCellReuseIdentifier:@"MyCell"];
    [self.sc addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
    
    self.tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    self.tb.backgroundColor = [UIColor systemBackgroundColor];
    [self.tb registerClass:[MyCell class] forCellReuseIdentifier:@"MyCell"];
    [self.sc addSubview:self.tb];
    self.tb.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, 500);
    _sc.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    
    _seg = [[UISegmentedControl alloc] init];
    _seg.backgroundColor = [UIColor systemBackgroundColor];
    [self.view addSubview:_seg];
    [_seg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom).offset(-20);
        make.width.equalTo(@130);
        make.height.equalTo(@50);
    }];
    [_seg insertSegmentWithTitle:@"合辑" atIndex:0 animated:YES];
    [_seg insertSegmentWithTitle:@"播客" atIndex:1 animated:YES];
    
    [_seg addTarget:self action:@selector(segchange:) forControlEvents:UIControlEventValueChanged];
}

-(void)segchange:(UISegmentedControl*)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    [self.sc setContentOffset:CGPointMake(index*self.view.bounds.size.width, 0)];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _sc){
        NSInteger page = scrollView.contentOffset.x / self.view.bounds.size.width;
        self.seg.selectedSegmentIndex = page;
    }
}

- (void)loadListData {
    self.dataSource = [NSMutableArray array];
    self.dataSource2 = [NSMutableArray array];
    MyModel *m1 = [[MyModel alloc] init];
    m1.name = @"我喜欢的音乐";
    m1.disc = @"494首·2296次播放";
    m1.image = @"like";
    
    MyModel *m2 = [[MyModel alloc] init];
    m2.name = @"原神-皎月云间之梦";
    m2.disc = @"专辑·69首·陈致逸";
    m2.image = @"yuan1";
    
    MyModel *m3 = [[MyModel alloc] init];
    m3.name = @"战地5原声带";
    m3.disc = @"歌单·37首·Sea-Blue";
    m3.image = @"zd";
    
    MyModel *m4 = [[MyModel alloc]init];
    m4.name = @"原神-闪耀的群星3";
    m4.disc = @"专辑·26首·HOYO-MiX";
    m4.image = @"yuan2";
    
    MyModel *m5 = [[MyModel alloc] init];
    m5.name = @"我喜欢播客";
    m5.disc = @"494首·2296次播放";
    m5.image = @"like";
    
    MyModel *m6 = [[MyModel alloc] init];
    m6.name = @"原神-播客1";
    m6.disc = @"专辑·69首·陈致逸";
    m6.image = @"yuan1";
    
    MyModel *m7 = [[MyModel alloc] init];
    m7.name = @"战地5播客";
    m7.disc = @"歌单·37首·Sea-Blue";
    m7.image = @"zd";
    
    MyModel *m8 = [[MyModel alloc]init];
    m8.name = @"原神-播客2";
    m8.disc = @"专辑·26首·HOYO-MiX";
    m8.image = @"yuan2";
    [self.dataSource addObjectsFromArray:@[m1,m2,m3,m4]];
    [self.dataSource2 addObjectsFromArray:@[m5,m6,m7,m8]];
    [self.tableView reloadData];
    [self.tb reloadData];
}

#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    if (tableView == self.tableView) {
            // 左侧列表
            MyModel *leftModel = self.dataSource[indexPath.row];
            [cell refreshWithModel:leftModel];
        } else {
            // 右侧tb列表
            MyModel *rightModel = self.dataSource2[indexPath.row];
            [cell refreshWithModel:rightModel];
        }
        return cell;
//    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
//    MyModel *model = self.dataSource[indexPath.row];
//    MyCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"tb"];
//    MyModel *model2 = self.dataSource[indexPath.row + 4];
//    [cell refreshWithModel:model];
//    [cell2 refreshWithModel:model2];
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 分栏切换方法


@end
