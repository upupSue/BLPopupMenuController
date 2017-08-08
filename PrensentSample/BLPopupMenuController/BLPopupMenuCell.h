//
//  BLPopupMenuCell.h
//  PrensentSample
//
//  Created by BroadLink on 2017/6/19.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLPopupMenuController.h"

@protocol MenuDelegate <NSObject>
@required
- (void)setPopupMenuCellUI:(BLPopupAction *)action;
@end

@interface BLPopupMenuCell : UITableViewCell<MenuDelegate>
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIImageView *checkImg;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) BOOL hasCheckImg;
@end
