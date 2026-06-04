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
#import "ThemeManager.h"

@interface MyController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyHeader *headerView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,assign)BOOL save;
@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.view addGestureRecognizer:tap];
    
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
    
    // 列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor systemBackgroundColor];
    self.tableView.tableHeaderView = self.headerView;
    //self.tableView.separatorColor = [UIColor darkGrayColor];
    [self.tableView registerClass:[MyCell class] forCellReuseIdentifier:@"MyCell"];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

// 加载歌单模拟数据
- (void)loadListData {
    self.dataSource = [NSMutableArray array];
    
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
    [self.dataSource addObjectsFromArray:@[m1,m2,m3,m4]];
    [self.tableView reloadData];
}

#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    MyModel *model = self.dataSource[indexPath.row];
    [cell refreshWithModel:model];
    return cell;
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

@end
