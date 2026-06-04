//
//  MyCell.m
//  网易云仿写
//
//  Created by luzi on 2026/5/31.
//

#import "MyCell.h"
#import "Masonry.h"
#import "MyModel.h"
@interface MyCell ()
@property (nonatomic, strong) UIImageView *coverImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCellUI];
    }
    return self;
}

- (void)setupCellUI {
    self.coverImg = [[UIImageView alloc] init];
    self.coverImg.layer.cornerRadius = 6;
    self.coverImg.clipsToBounds = YES;
    self.coverImg.backgroundColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.coverImg];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor labelColor];
    self.nameLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self.contentView addSubview:self.nameLabel];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.textColor = [UIColor lightGrayColor];
    self.descLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.descLabel];
    
    // 布局
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.equalTo(self.contentView).inset(12);
        make.width.height.mas_equalTo(60);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImg.mas_right).offset(15);
        make.top.equalTo(self.coverImg.mas_top).offset(5);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
    }];
}

- (void)refreshWithModel:(MyModel*)model
{
    self.coverImg.image = [UIImage imageNamed:model.image];
    self.nameLabel.text = model.name;
    self.descLabel.text = model.disc;
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
