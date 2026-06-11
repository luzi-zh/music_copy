#import "PageScrollCell.h"
#import "Masonry/Masonry.h"
// 单个 Item Cell
@interface PageItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *coverImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subLab;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic,assign) BOOL isPlay;

@end

@implementation PageItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.contentView.backgroundColor = [UIColor systemBackgroundColor];
    }
    return self;
}

- (void)setupUI {
    // 封面图
    _coverImg = [[UIImageView alloc] init];
    _coverImg.layer.cornerRadius = 8;
    _coverImg.clipsToBounds = YES;
    _coverImg.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_coverImg];
    
    // 标题
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textColor = [UIColor labelColor];
    
    [self.contentView addSubview:_titleLab];
    
    // 副标题
    _subLab = [[UILabel alloc] init];
    _subLab.font = [UIFont systemFontOfSize:12];
    _subLab.textColor = [UIColor grayColor];
    [self.contentView addSubview:_subLab];
    
    //按钮
    _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
    [_btn addTarget:self action:@selector(change:) forControlEvents:(UIControlEventTouchDown)];
    [self.contentView addSubview:_btn];
    _btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _btn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
}
-(void)change:(UIButton*)btn
{
//    self.isPlay = !self.isPlay;
//    if(self.isPlay){
//        [_btn setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
//    }else{
//        [_btn setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
//    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    
    _coverImg.frame = CGRectMake(15, 12, 70, 70);
    _titleLab.frame = CGRectMake(95, 20, w-110, 18);
    _subLab.frame = CGRectMake(95, 48, w-110, 15);
//    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).offset(-10);
//        make.centerY.equalTo(self.contentView);
//        make.width.equalTo(@40);
//        make.height.equalTo(@40);
//    }];
}

@end

// --------------------------- 主 Cell ---------------------------

@interface PageScrollCell () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *pages; // 每页的数据

@end

@implementation PageScrollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        self.contentView.backgroundColor = [UIColor systemBackgroundColor];
    }
    return self;
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor systemBackgroundColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[PageItemCell class] forCellWithReuseIdentifier:@"PageItemCell"];
    
    [self.contentView addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}


- (void)setPageDataArray:(NSArray<NSDictionary *> *)pageDataArray {
    _pageDataArray = pageDataArray;
    
    // 拆分成每页最多3条数据
    NSMutableArray *pages = [NSMutableArray array];
    NSInteger pageSize = 3;
    for (NSInteger i = 0; i < pageDataArray.count; i += pageSize) {
        NSRange range = NSMakeRange(i, MIN(pageSize, pageDataArray.count - i));
        NSArray *subArray = [pageDataArray subarrayWithRange:range];
        [pages addObject:subArray];
    }
    self.pages = pages;
    
    [self.collectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.pages.count; // 每页一个 section
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3; // 每页行数
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PageItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PageItemCell" forIndexPath:indexPath];
    NSDictionary *data = self.pages[indexPath.section][indexPath.item];
    cell.coverImg.image = [UIImage imageNamed:data[@"image"]];
    cell.titleLab.text = data[@"title"];
    cell.subLab.text = data[@"subTitle"];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = collectionView.bounds.size.width; // 一行铺满
    CGFloat h = 90; // 每行高度
    return CGSizeMake(w, h);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10; // 行间距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
