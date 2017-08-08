//
//  BLPopupMenuController.m
//  PrensentSample
//
//  Created by 方琼蔚 on 17/7/23.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "BLPopupMenuController.h"
#import "BLPopupMenuCell.h"
#import "BLPopupMenuTransition.h"

#define KCELLHEIGHT 58

static NSString *kDefaultCellId = @"defaultCellId";
static NSString *kUserCellId = @"userCellId";

@interface BLPopupAction()
@property (nullable, nonatomic, readwrite) NSString *title;
@property (nonatomic, copy) void (^event)(BLPopupAction *action);
@end

@implementation BLPopupAction

+ (instancetype)actionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(BLPopupAction *action))handler
{
    BLPopupAction *action = [[BLPopupAction alloc] init];
    action.title = title;
    action.event = handler;
    action.enabled = YES;
    return action;
}

- (id)copyWithZone:(NSZone *)zone
{
    BLPopupAction *action = [[[self class] allocWithZone:zone] init];
    action.title = self.title;
    action.enabled = self.enabled;
    return action;
}

@end

@interface BLPopupMenuController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak, nullable) id<MenuDelegate> delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BLPopupMenuTransition *transition;
@property (nonatomic, readwrite) BLPopupMenuControllerStyle preferredStyle;
@property (nonatomic, readwrite) NSMutableArray<BLPopupAction *> *actions;
@property (nonatomic, strong) NSString *cellClassName;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation BLPopupMenuController

+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle;
{
    BLPopupMenuController *vc = [[BLPopupMenuController alloc] init];
    vc.cellHeight = KCELLHEIGHT;
    vc.preferredStyle = preferredStyle;
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transition=[[BLPopupMenuTransition alloc] init];
    vc.transitioningDelegate = vc.transition;
    
    return vc;
}

+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle origin:(CGPoint)startPoint
{
    BLPopupMenuController *vc = [[BLPopupMenuController alloc] init];
    vc.cellHeight = KCELLHEIGHT;
    vc.preferredStyle = preferredStyle;
    vc.startPoint = startPoint;
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transition=[[BLPopupMenuTransition alloc] init];
    vc.transitioningDelegate = vc.transition;
    
    return vc;
}


+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle cellClassName:(NSString *)cellClassName cellHeight:(CGFloat)cellHeight
{
    BLPopupMenuController *vc = [[BLPopupMenuController alloc] init];
    vc.preferredStyle = preferredStyle;
    vc.cellClassName = cellClassName;
    vc.cellHeight = cellHeight;
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transition=[[BLPopupMenuTransition alloc] init];
    vc.transitioningDelegate = vc.transition;
    return vc;
}

+ (instancetype)popupMenuControllerWithPreferredStyle:(BLPopupMenuControllerStyle)preferredStyle origin:(CGPoint)startPoint cellClassName:(NSString *)cellClassName cellHeight:(CGFloat)cellHeight
{
    BLPopupMenuController *vc = [[BLPopupMenuController alloc] init];
    vc.preferredStyle = preferredStyle;
    vc.startPoint = startPoint;
    vc.cellClassName = cellClassName;
    vc.cellHeight = cellHeight;
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transition=[[BLPopupMenuTransition alloc] init];
    vc.transitioningDelegate = vc.transition;
    return vc;
}

- (void)addAction:(BLPopupAction *)action
{
    if(_actions == nil){
        _actions = [[NSMutableArray alloc] init];
    }
    [_actions addObject:action];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self countContentSize];
    [self countStartPoint];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.startPoint.x, self.startPoint.y, self.contentSize.width, self.contentSize.height)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(-3,5);
    bgView.layer.shadowOpacity = 0.5;
    bgView.layer.shadowRadius = 10;
    [self.view addSubview:bgView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
    [bgView addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    _separatorColor == nil ? [self.tableView setSeparatorColor:[UIColor grayColor]] : [self.tableView setSeparatorColor:_separatorColor];
    
    if(self.cellClassName != nil){
        Class usercellClass = NSClassFromString(self.cellClassName);
        [self.tableView registerClass:usercellClass forCellReuseIdentifier:kUserCellId];
    }
    else [self.tableView registerClass:[BLPopupMenuCell class] forCellReuseIdentifier:kDefaultCellId];
    
    if(_preferredStyle == BLPopupMenuControllerStyleDefault) self.tableView.scrollEnabled = NO;
    if(_preferredStyle == BLPopupMenuControllerStyleSelected && _actions.count <= _maxRowNumber) self.tableView.scrollEnabled = NO;

}

#pragma mark - 计算显示的大小和起始位置

- (void)countContentSize
{
    CGFloat width;
    CGFloat height;

    switch (_preferredStyle) {
        case BLPopupMenuControllerStyleDefault:{
            width = 75;
            height = self.cellHeight * _actions.count;
            for(BLPopupAction *action in self.actions){
                CGSize sizeToFit = [action.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                
                if(sizeToFit.width > width){
                    width = sizeToFit.width;
                }
            }
            width = width + 15 + 40;
            if(width > 185) width = 185;
            break;
        }
            
        case BLPopupMenuControllerStyleSelected:{
            width = 120;
            NSString *title;
            
            if (_maxRowNumber == 0) {
                _maxRowNumber = 6;
            }
            if (_maxTitleLength == 0) {
                _maxTitleLength = 16;
            }
            (_actions.count > _maxRowNumber) ? (height = self.cellHeight * _maxRowNumber) : (height = self.cellHeight * _actions.count);
            
            for (BLPopupAction *action in self.actions) {
                
                NSRange textRange = [self calculateRangeWithText:action.title maxLength:8];
                if (textRange.length != action.title.length) {
                    title = [action.title substringWithRange:NSMakeRange(0, textRange.length)];
                    title = [title stringByAppendingString:@"..."];
                }
                else title = action.title;
                
                CGSize sizeToFit = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                
                if(sizeToFit.width > width){
                    width = sizeToFit.width;
                }
            }
            for (BLPopupAction *action in self.actions) {
                NSRange textRange = [self calculateRangeWithText:action.title maxLength:8];
                if (textRange.length != action.title.length) {
                    title = [action.title substringWithRange:NSMakeRange(0, textRange.length)];
                    title = [title stringByAppendingString:@"..."];
                    CGSize sizeToFit = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                    
                    if(sizeToFit.width >= (width - 2)){//增加2个px 用于解决label放不下的情况
                        action.title = title;
                    }
                }
            }
            
            width = width + 15 + 65;
            break;
        }
            
        default:
            break;
    }
    
    if((height + 20 + 20) > [UIScreen mainScreen].bounds.size.height)
        height = [UIScreen mainScreen].bounds.size.height - 40;
    if((width + 10 + 10) > [UIScreen mainScreen].bounds.size.width)
        width = [UIScreen mainScreen].bounds.size.width - 20;

    self.contentSize = CGSizeMake(width, height);
}

- (void)countStartPoint
{
    CGFloat x;
    CGFloat y;
    if(CGPointEqualToPoint(self.startPoint, CGPointZero)){
        x = [UIScreen mainScreen].bounds.origin.x + 10;
        y = 20;
    }
    else{
        x = self.startPoint.x;
        y = self.startPoint.y;
        if((self.startPoint.x + self.contentSize.width) > [UIScreen mainScreen].bounds.size.width){
            ((self.startPoint.x - self.contentSize.width) < 10) ? (x = 10) : (x = self.startPoint.x - self.contentSize.width);
        }
        if ((self.startPoint.y + self.contentSize.height) > [UIScreen mainScreen].bounds.size.height){
            ((self.startPoint.y - self.contentSize.height) < 20) ? (y = 20) : (y = self.startPoint.y - self.contentSize.height);
        }
    }
    
    self.startPoint = CGPointMake(x, y);
}

- (NSRange)calculateRangeWithText:(NSString *)textA maxLength:(NSInteger)length
{
    float number = 0.0;
    int index;
    for (index = 0; index < [textA length]; index++) {
        
        NSString *character = [textA substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number++;
        } else {
            number = number+0.5;
        }
        if (number > 8) {
            return NSMakeRange(0, index);
        }
    }
    return NSMakeRange(0, textA.length);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:NO completion:nil];
    if(_actions[indexPath.row].enabled){
        _actions[indexPath.row].event(_actions[indexPath.row]);
    }
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.cellClassName != nil){
        id cell = [self.tableView dequeueReusableCellWithIdentifier:kUserCellId forIndexPath:indexPath];
        
        self.delegate = cell;
        [self.delegate setPopupMenuCellUI:_actions[indexPath.row]];
        return cell;
    }
    else{
        BLPopupMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellId forIndexPath:indexPath];
        if(_preferredStyle == BLPopupMenuControllerStyleSelected){
            cell.hasCheckImg = true;
            if(indexPath.row == self.selectedIndex)
                cell.checkImg.image = [UIImage imageNamed:@"icon_checkmark"];
            else cell.checkImg.image = nil;
        }
        else{
            cell.checkImg.hidden = YES;
            cell.hasCheckImg = false;
        }
        self.delegate = cell;
        [self.delegate setPopupMenuCellUI:_actions[indexPath.row]];
        return cell;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
