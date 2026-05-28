//
//  cover.m
//  网易云仿写
//
//  Created by luzi on 2026/5/27.
//

#import "cover.h"
#import "Masonry/Masonry.h"
@implementation cover


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.img = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.width.mas_equalTo(self.contentView.bounds.size.width);
            make.height.mas_equalTo(self.contentView.bounds.size.height);
        }];
        self.img.layer.cornerRadius = 10;
        self.img.clipsToBounds = YES;
        self.lab = [[UILabel alloc]init];
        self.lab.textAlignment = NSTextAlignmentCenter;
        [self.img addSubview:self.lab];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.img).offset(-10);
            make.centerX.equalTo(self.img);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        self.lab.textColor = [UIColor whiteColor];
    }
    return self;
}



@end
