//
//  TestTableViewCell.m
//  PrensentSample
//
//  Created by 方琼蔚 on 17/6/23.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selected = NO;
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.textColor = [UIColor redColor];
        [_bgView addSubview:_titleLable];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _titleLable.frame = CGRectMake(15, (self.frame.size.height - 18)/2, self.frame.size.width - 15 - 15, 18);
}

- (void)setPopupMenuCellUI:(BLPopupAction *)action
{
    self.titleLable.text = action.title;
}

@end
