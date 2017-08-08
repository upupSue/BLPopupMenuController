//
//  TestTableViewCell.h
//  PrensentSample
//
//  Created by 方琼蔚 on 17/6/23.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLPopupMenuCell.h"

@interface TestTableViewCell : UITableViewCell<MenuDelegate>
@property(nonatomic, strong) UILabel *titleLable;
@property(nonatomic, strong) UIImageView *checkImg;
@property(nonatomic, strong) UIView *bgView;
@end
