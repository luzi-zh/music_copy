//
//  HomeCanner.m
//  网易云仿写
//
//  Created by luzi on 2026/5/20.
//

#import "HomeCanner.h"
#import "Masonry/Masonry.h"
@implementation HomeCanner
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 25, 800, 200))];
    _scrollView.pagingEnabled = NO;
    _scrollView.alwaysBounceVertical = NO;  // 禁止垂直方向弹跳
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(775, 125);
    [self.contentView addSubview:_scrollView];
    NSArray* array = @[@"m1",@"m2",@"m3",@"m4",@"m5"];
    NSArray* tarr = @[@"超好听的二游歌曲",@"一定听过的史诗神级配乐",@"EVA插曲主题曲",@"写作业听书曲爽",@"《生化奇兵系列》OST"];
    for(int i = 0; i < 5; i++){
        UIImageView*iv = [[UIImageView alloc]initWithFrame:(CGRectMake(i*150+25, 25, 125, 125))];
        iv.image = [UIImage imageNamed:array[i]];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.cornerRadius = 12;
        iv.layer.masksToBounds = YES;
        iv.clipsToBounds = YES;
        [self.scrollView addSubview:iv];
        UIImage* play = [UIImage imageNamed:@"play"];
        UIImageView* img = [[UIImageView alloc] initWithImage:play];
        [iv addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(iv).offset(-10);
            make.right.equalTo(iv).offset(-10);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        //下方文案
        UILabel* tv = [[UILabel alloc] init];
        [_scrollView addSubview: tv];
        [tv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iv).offset(130);
            make.centerX.equalTo(iv);
            make.width.equalTo(iv);
            make.height.equalTo(@40);
        }];
        tv.font = [UIFont systemFontOfSize:12];
        tv.text = tarr[i];
        tv.textColor = [UIColor labelColor];
        tv.textAlignment = NSTextAlignmentCenter;
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
