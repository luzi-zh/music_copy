#import "Setting.h"
#import "Masonry/Masonry.h"
#import "SetCell.h"
#import "black.h"


@interface Setting ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *bgMask;
@property(nonatomic,copy)NSArray* arrI;
@property(nonatomic,copy)NSArray* arrL;
@property(nonatomic,strong)UITableView* set;
@property(nonatomic,strong)UITableView* black;
@end

@implementation Setting

-(void)viewDidLoad
{
    [super viewDidLoad];
    
#pragma mark 头像
    UIImageView* myI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"king"]];
    [self.view addSubview:myI];
    [myI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.equalTo(self.view).offset(15);
        make.width.height.equalTo(@60);
    }];
    myI.layer.cornerRadius = 30;
    myI.clipsToBounds = YES;
    
#pragma mark 昵称
    UILabel* myN = [[UILabel alloc] init];
    [self.view addSubview:myN];
    [myN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(myI);
        make.left.equalTo(myI).offset(90);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    myN.text = @"luzi";
    
#pragma mark 充钱图片
    UIImageView* give = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"give"]];
    [self.view addSubview:give];
    [give mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myI).offset(70);
        make.left.equalTo(myI);
        make.width.equalTo(@240);
        make.height.equalTo(@140);
    }];
    give.layer.cornerRadius = 12;
    give.clipsToBounds = YES;
    
#pragma mark 设置
    _set = [[UITableView alloc]initWithFrame:CGRectMake(0, 280, 240, 500) style:(UITableViewStylePlain)];
    _set.delegate = self;
    _set.dataSource = self;
    _arrI = @[@"letter",@"cloud",@"cloth",@"lamp",@"timer",@"alarm",@"bag",@"ticket",@"fire",@"buds"];
    _arrL = @[@"我的消息",@"我的云贝",@"装扮中心",@"创作者中心",@"最近播放",@"定时关闭",@"商场",@"云村有票",@"云推歌",@"我的客服"];
    _set.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_set registerClass:[SetCell class] forCellReuseIdentifier:@"setcell"];
    [_set registerClass:[black class] forCellReuseIdentifier:@"black"];
    [self.view addSubview:_set];
    
//    _black = [[UITableView alloc] initWithFrame:(CGRectMake(0, 780, 240, 50)) style:(UITableViewStylePlain)];
//    _black.delegate = self;
//    _black.dataSource = self;
//    _black.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_black registerClass:[black class] forCellReuseIdentifier:@"blackcell"];
//    [self.view addSubview:_black];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrI.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _arrI.count) {
            NSString* str = @"setcell";
            SetCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
            if(cell == nil){
                cell = [[SetCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
            }
            cell.leftImg.image = [UIImage imageNamed:_arrI[indexPath.row]];
            cell.label.text = _arrL[indexPath.row];
            return cell;
        }
    else if (indexPath.row == 10) {
        NSString* str = @"blackcell";
        black* cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell == nil){
            cell = [[black alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftImg.image = [UIImage imageNamed:@"black"];
        cell.label.text = @"黑夜模式";
        cell.swV.userInteractionEnabled = YES;
        cell.swV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        return cell;
        }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < _arrI.count){
        [_set deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)show {
    UIWindow *topWin = [UIApplication sharedApplication].keyWindow;
    
    // 半透明背景
    self.bgMask = [[UIView alloc] initWithFrame:topWin.bounds];
    self.bgMask.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [topWin addSubview:self.bgMask];
    
    // 给 window 加点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.bgMask addGestureRecognizer:tap];
    
    CGFloat w = topWin.bounds.size.width * 0.7;
    CGFloat h = topWin.bounds.size.height;
    
    self.view.frame = CGRectMake(-w, 0, w, h);
    self.view.backgroundColor = UIColor.whiteColor;
    [topWin addSubview:self.view];
    
    [topWin.rootViewController addChildViewController:self];
    [self didMoveToParentViewController:topWin.rootViewController];
    
    // 滑入动画
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, w, h);
    }];
}

- (void)hide {
    CGFloat w = self.view.frame.size.width;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(-w, 0, w, self.view.frame.size.height);
        self.bgMask.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self.bgMask removeFromSuperview];
        
        [self removeFromParentViewController]; // 移除自己
    }];
}

@end
