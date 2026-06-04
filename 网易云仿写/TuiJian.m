#import "TuiJian.h"
#import "Masonry/Masonry.h"
#import "HomeBanner.h"
#import "PageScrollCell.h"
#import "HomeCanner.h"
#import "Setting.h"


@interface TuiJian ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,assign)BOOL save;
@end

@implementation TuiJian

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    //cell
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor systemBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //滑动时收起键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[HomeBanner class] forCellReuseIdentifier:@"bannercell"];
    [self.tableView registerClass:[PageScrollCell class] forCellReuseIdentifier:@"scrollcell"];
    [self.tableView registerClass:[HomeCanner class] forCellReuseIdentifier:@"cannercell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];

}


- (void)hideKeyboard {
    [self.searchBar resignFirstResponder];
}


-(void)rightBtnClick
{
    NSLog(@"听歌识曲");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 250;
    if (indexPath.section == 1) return 300;
    return 300;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
            HomeBanner *cell = [tableView dequeueReusableCellWithIdentifier:@"bannercell" forIndexPath:indexPath];
            return cell;
        }
    else if (indexPath.section == 1) {
           PageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrollcell" forIndexPath:indexPath];
           
           // 赋值翻页数据
           NSArray *pageData = @[
               @{@"image": @"hao", @"title": @"不将就", @"subTitle": @"李荣浩"},
               @{@"image": @"jay", @"title": @"说了再见", @"subTitle": @"周杰伦"},
               @{@"image": @"jj", @"title": @"那些你很冒险的梦", @"subTitle": @"林俊杰"},
               @{@"image": @"bo", @"title": @"曾经是情侣", @"subTitle": @"梁博"},
               @{@"image": @"teng", @"title": @"怎么说我不爱你", @"subTitle": @"萧敬腾"},
               @{@"image": @"hong", @"title": @"唯一", @"subTitle": @"王力宏"}
           ];
           cell.pageDataArray = pageData;
           
           return cell;
       }
    else{
        HomeCanner* cell = [tableView dequeueReusableCellWithIdentifier:@"cannercell" forIndexPath:indexPath];
        return cell;
    }
       
       return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
    headView.backgroundColor = [UIColor systemBackgroundColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 25)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    if (section == 0) {
        titleLabel.text = @"分类合集";
    }
    if (section == 1) {
        titleLabel.text = @"热门歌曲";
    }
    if(section == 2) {
        titleLabel.text = @"推荐歌单";
    }
    [headView addSubview:titleLabel];
    return headView;
}


#pragma mark 弹出设置页面
-(void)tanchu
{
    Setting *set = [[Setting alloc] init];
    [set show];
}

@end
