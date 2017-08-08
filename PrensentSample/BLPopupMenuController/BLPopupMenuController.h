//
//  BLPopupMenuController.h
//  PrensentSample
//
//  Created by 方琼蔚 on 17/7/23.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BLPopupMenuControllerStyle) {
    BLPopupMenuControllerStyleDefault = 0,
    BLPopupMenuControllerStyleSelected= 1
};


@interface BLPopupAction : NSObject <NSCopying>
+ (instancetype)actionWithTitle:(nullable NSString *)title handler:(void (^__nullable)(BLPopupAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@end


@interface BLPopupMenuController : UIViewController

+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle;

+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle
                                        cellClassName:(NSString *)cellClassName
                                           cellHeight:(CGFloat)cellHeight;

+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle
                                               origin:(CGPoint)startPoint;

+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle
                                               origin:(CGPoint)startPoint
                                        cellClassName:(NSString *)cellClassName
                                           cellHeight:(CGFloat)cellHeight;

- (void)addAction:(BLPopupAction *)action;

@property (nonatomic, readonly) BLPopupMenuControllerStyle preferredStyle;
@property (nonatomic, readonly) NSArray<BLPopupAction *> *actions;
@property (nonatomic, assign) CGPoint startPoint;                          //弹框的起始位置
@property (nonatomic, assign) NSInteger selectedIndex;                     //当前选中的行数
@property (nonatomic, assign) NSInteger maxRowNumber;                      //弹框显示的最大长度，超出之后滚动显示
@property (nonatomic, assign) NSInteger maxTitleLength;                    //每行显示的最大字符串长度，一个长度=1个中文=2个英文
@property (nonatomic, strong, nullable) UIColor *separatorColor;

@end

NS_ASSUME_NONNULL_END

