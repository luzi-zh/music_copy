//
//  MyCell.h
//  网易云仿写
//
//  Created by luzi on 2026/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MyModel;
@interface MyCell : UITableViewCell
- (void)refreshWithModel:(MyModel *)model;
@end

NS_ASSUME_NONNULL_END
