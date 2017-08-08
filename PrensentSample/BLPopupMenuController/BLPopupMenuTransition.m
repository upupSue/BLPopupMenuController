//
//  PresentationTransition.m
//  PrensentSample
//
//  Created by BroadLink on 2017/6/20.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "BLPopupMenuController.h"
#import "BLPopupMenuTransition.h"
#import "BLPopupMenuAnimation.h"

@interface BLPopupMenuTransition ()
@property (nonatomic, strong) BLPopupMenuAnimation *animation;
@end

@implementation BLPopupMenuTransition

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self generateAnimatorWithPresenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self generateAnimatorWithPresenting];
}

- (BLPopupMenuAnimation *)generateAnimatorWithPresenting
{
    if (!_animation) {
        _animation = [[BLPopupMenuAnimation alloc] init];
    }
    return _animation;
}

@end
