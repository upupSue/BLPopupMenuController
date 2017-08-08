//
//  PresentationAnimation.m
//  PrensentSample
//
//  Created by BroadLink on 2017/6/19.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "BLPopupMenuAnimation.h"

@interface BLPopupMenuAnimation ()
@end

@implementation BLPopupMenuAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.alpha = 0;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:0.2 animations:^{
        toView.alpha = 1.0;
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
