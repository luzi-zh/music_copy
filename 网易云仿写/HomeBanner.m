//
//  HomeBannerCellTableViewCell.m
//  网易云仿写
//
//  Created by luzi on 2026/5/19.
//

#import "HomeBanner.h"
#import "Masonry/Masonry.h"
@implementation HomeBanner
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupUI];
        self.contentView.backgroundColor = [UIColor systemBackgroundColor];
    }
    return self;
}

-(void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 25, 800, 250))];
    _scrollView.pagingEnabled = NO;
    _scrollView.alwaysBounceVertical = NO;  // 禁止垂直方向弹跳
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(775, 250);
    [self.contentView addSubview:_scrollView];
    NSArray* array = @[@"i1",@"i2",@"i3",@"i4",@"i5"];
    NSArray* sarr = @[@"人生本来就是遗憾的",@"经典必听",@"泪水会淹没回忆",@"我们伟大且渺小",@"向死而生"];
    for(int i = 0; i < 5; i++){
        UIImageView*iv = [[UIImageView alloc]initWithFrame:(CGRectMake(i*150+25, 25, 125, 200))];
        iv.image = [UIImage imageNamed:array[i]];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.cornerRadius = 12;  // 数字越大，角越圆
        iv.layer.masksToBounds = YES; // 必须加，否则圆角不生效
        iv.clipsToBounds = YES;
        [self.scrollView addSubview:iv];
        UIView *bgView = [[UIView alloc] init];
        [iv addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(iv);
            make.width.equalTo(iv);
            make.height.equalTo(@25);
        }];
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:bgView.bounds];
        titleLab.text = sarr[i];
        titleLab.textColor = [UIColor whiteColor];
        titleLab.font = [UIFont systemFontOfSize:13];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.width.equalTo(bgView);
            make.height.equalTo(bgView);
        }];
        UIImage* play = [UIImage imageNamed:@"play"];
        UIImageView* img = [[UIImageView alloc] initWithImage:play];
        [iv addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgView).offset(-25);
            make.right.equalTo(iv).offset(-10);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
