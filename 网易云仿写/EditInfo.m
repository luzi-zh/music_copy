//
//  EditInfo.m
//  网易云仿写
//
//  Created by luzi on 2026/6/2.
//

#import "EditInfo.h"
#import "AvatarManager.h"
#define kPhotoCount 9
#define kCellID @"PhotoCell"
@interface EditInfo ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageNames;
@property (nonatomic, assign) NSInteger selectedIndex; // 单选用
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation EditInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = -1;
    
    // 模拟图片名数组
    self.imageNames = [NSMutableArray array];
    for (int i=1; i<=kPhotoCount; i++) {
        [self.imageNames addObject:[NSString stringWithFormat:@"%d", i]];
    }
    [self setupCollectionView];
    [self setupBottomButton];

}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat w = (self.view.bounds.size.width - 40) / 3;
    layout.itemSize = CGSizeMake(w, w);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 200) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellID];
    [self.view addSubview:self.collectionView];
}

- (void)setupBottomButton {
    self.confirmButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    self.confirmButton.frame = CGRectMake(self.view.bounds.size.width/2-60,550,100 , 50);
    self.confirmButton.backgroundColor = [UIColor systemBlueColor];
    [self.confirmButton setTitle:@"设置为头像" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(onConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];

    // 图片
    UIImageView *imgView = [cell viewWithTag:100];
    if (!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imgView.tag = 100;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [cell addSubview:imgView];
    }
    imgView.image = [UIImage imageNamed:self.imageNames[indexPath.item]];

    // 选中边框
    cell.layer.cornerRadius = 6;
    cell.layer.masksToBounds = YES;
    if (self.selectedIndex == indexPath.item) {
        cell.layer.borderColor = [UIColor systemBlueColor].CGColor;
        cell.layer.borderWidth = 3;
    } else {
        cell.layer.borderColor = nil;
        cell.layer.borderWidth = 0;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndex == indexPath.item) {
        self.selectedIndex = -1; // 取消
    } else {
        self.selectedIndex = indexPath.item; // 单选互斥
    }
    [collectionView reloadData];
}

- (void)onConfirmClick {
    NSInteger count = (self.selectedIndex >= 0) ? 1 : 0;

    if (count == 0) {
        [self showAlertWithMessage:@"请选择一张照片"];
        return;
    }


    // 正常设置头像
    UIImage *avatar = [UIImage imageNamed:self.imageNames[self.selectedIndex]];
    [AvatarManager sharedManager].avatarImage = avatar;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AvatarChanged" object:nil];
    [self showAlertWithMessage:@"头像设置成功！"];
}

- (void)showAlertWithMessage:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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
