//
//  MyHeader.m
//  网易云仿写
//
//  Created by luzi on 2026/5/31.
//

#import "MyHeader.h"
#import "EditInfo.h"
#import "Masonry/Masonry.h"
#import "AvatarManager.h"
@implementation MyHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAvatar) name:@"AvatarChanged" object:nil];
        [self setupHeaderUI];
        self.backgroundColor = [UIColor systemBackgroundColor];
    }
    return self;
}

-(void)setupHeaderUI
{
    
    _Myimg = [[UIImageView alloc]init];
    _Myimg.backgroundColor = [UIColor lightGrayColor];
    _Myimg.layer.cornerRadius = 45;
    _Myimg.clipsToBounds = YES;
    _Myimg.image = [AvatarManager sharedManager].avatarImage ?: [UIImage imageNamed:@"king"];
    [self addSubview:_Myimg];
    
    _Myimg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goEditInfo)];
    [_Myimg addGestureRecognizer:tap];
    
    UILabel* nameLab = [[UILabel alloc]init];
    nameLab.text = @"luzi_z";
    nameLab.textColor = [UIColor labelColor];
    nameLab.font = [UIFont boldSystemFontOfSize:22];
    [self addSubview:nameLab];
    
    UILabel* infoLab = [[UILabel alloc]init];
    infoLab.text = @"9关注   1粉丝   Lv.8   350小时";
    infoLab.textColor = [UIColor lightGrayColor];
    infoLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:infoLab];
    
    NSArray *btnTitles = @[@"最近",@"本地",@"网盘",@"装扮"];
    CGFloat btnW = 70;
    for (int i=0; i<btnTitles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
        btn.layer.cornerRadius = 12;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infoLab.mas_bottom).offset(20);
            make.left.equalTo(self.mas_left).offset(35 + i*(btnW+10));
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(40);
        }];
    }
    
    [_Myimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(90);
    }];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Myimg.mas_bottom).offset(12);
        make.centerX.equalTo(self);
    }];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).offset(12);
        make.centerX.equalTo(self);
    }];
}

-(void)goEditInfo
{
    EditInfo* edit = [[EditInfo alloc]init];
    
    [self.parentVC.navigationController pushViewController:edit animated:YES];
}


// 刷新头像
- (void)updateAvatar {
    _Myimg.image = [AvatarManager sharedManager].avatarImage;
}

// 移除监听
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
