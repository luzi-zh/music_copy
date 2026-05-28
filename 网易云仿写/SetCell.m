//
//  SetCell.m
//  网易云仿写
//
//  Created by luzi on 2026/5/26.
//

#import "SetCell.h"
#import "Masonry/Masonry.h"
@implementation SetCell



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
    //图片
    _leftImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftImg];
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(@15);
        make.width.height.equalTo(@30);
    }];
    _leftImg.layer.cornerRadius = 10;
    _leftImg.contentMode = UIViewContentModeScaleAspectFit;
    _leftImg.clipsToBounds = YES;
    
    //文字
    _label = [[UILabel alloc]init];
    [self.contentView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_leftImg).offset(50);
    }];
    
    
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
