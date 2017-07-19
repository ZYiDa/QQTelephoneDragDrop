//
//  ZTransition.m
//  拖拽控件
//
//  Created by YYKit on 2017/6/12.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "ZTransition.h"
#import "ViewController.h"

#define Animaton_Time 0.5f
@implementation ZTransition

+ (instancetype)transitionWithType:(ZTransitionType)transitionType
{
    return [[self alloc]initWithTransitionType:transitionType];
}

- (instancetype)initWithTransitionType:(ZTransitionType)transitionType
{
    self = [super init];
    if (self)
    {
        self.transitionType = transitionType;
    }
    return self;
}


#pragma mark 转场动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return Animaton_Time;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.transitionType)
    {
        case ZTransitionTypeShow:
        {
            [self showAnimaton:transitionContext];
        }
            break;
        case ZTransitionTypeDismiss:
        {
            [self dismissAnimation:transitionContext];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- show
- (void)showAnimaton:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController * fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController * temVC = fromVC.viewControllers.lastObject;
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    //TODO:画两个圆
    UIBezierPath *startRound = [UIBezierPath bezierPathWithOvalInRect:temVC.roundFrame];
    CGFloat x = MAX(temVC.roundFrame.origin.x, containerView.frame.size.width - temVC.roundFrame.origin.x);
    CGFloat y = MAX(temVC.roundFrame.origin.y, containerView.frame.size.height - temVC.roundFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    UIBezierPath *endRound = [UIBezierPath bezierPathWithArcCenter:containerView.center
                                                            radius:radius
                                                        startAngle:0
                                                          endAngle:M_PI * 2
                                                         clockwise:YES];
    //TODO:创建CAShpeLayer遮罩层
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endRound.CGPath;
    toVC.view.layer.mask = maskLayer;

    //TODO:动画路径
    CABasicAnimation *maskLayerAni = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAni.delegate = self;
    maskLayerAni.fromValue = (__bridge id _Nullable)(startRound.CGPath);
    maskLayerAni.toValue = (__bridge id _Nullable)(endRound.CGPath);
    maskLayerAni.duration = [self transitionDuration:transitionContext];
    maskLayerAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAni setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAni forKey:@"path"];

}

#pragma mark ---dismiss
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    ViewController *tempVC = toVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];

    //TODO:画两个圆
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width)/2;
    UIBezierPath *startRoundPath = [UIBezierPath bezierPathWithArcCenter:containerView.center
                                                                  radius:radius
                                                              startAngle:0
                                                                endAngle:M_PI * 2
                                                               clockwise:YES];
    UIBezierPath *endRoundPath = [UIBezierPath bezierPathWithOvalInRect:tempVC.roundFrame];

    //TODO:创建遮罩层
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor colorWithRed:32/255 green:62/255 blue:85/255 alpha:1.0].CGColor;
    maskLayer.path = endRoundPath.CGPath;
    fromVC.view.layer.mask = maskLayer;

    //TODO:创建专场动画路径
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.delegate = self;
    maskAnimation.fromValue = (__bridge id _Nullable)(startRoundPath.CGPath);
    maskAnimation.toValue = (__bridge id _Nullable)(endRoundPath.CGPath);
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (self.transitionType)
    {
        case ZTransitionTypeShow:
        {
            id<UIViewControllerContextTransitioning>transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case ZTransitionTypeDismiss:
        {
            id<UIViewControllerContextTransitioning>transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled])
            {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;;
            }
        }
            break;
        default:
            break;
    }
}
@end
