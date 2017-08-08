//
//  BLPopupMenuCell.m
//  PrensentSample
//
//  Created by BroadLink on 2017/6/19.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "BLPopupMenuCell.h"

@implementation BLPopupMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selected = NO;
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];

        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.textColor = [UIColor blackColor];
        [_bgView addSubview:_titleLable];
        
        _checkImg = [[UIImageView alloc] init];
        _checkImg.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_checkImg];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _bgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _hasCheckImg ? (_titleLable.frame = CGRectMake(15, (self.frame.size.height - 18) / 2, self.frame.size.width - 15 - 65, 18)) : (_titleLable.frame = CGRectMake(15, (self.frame.size.height - 18) / 2, self.frame.size.width - 15 - 40, 18));
    _checkImg.frame = CGRectMake(self.frame.size.width - 33, (self.frame.size.height - 13) / 2, 13, 13);
}

- (void)setPopupMenuCellUI:(BLPopupAction *)action
{
    self.titleLable.text = action.title;
}


@end

