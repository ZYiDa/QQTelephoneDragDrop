//
//  ZTransition.h
//  拖拽控件
//
//  Created by YYKit on 2017/6/12.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,ZTransitionType)
{
    ZTransitionTypeShow = 0,
    ZTransitionTypeDismiss
};
@interface ZTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

/*
 *转场动画操作type
 */
@property (assign,nonatomic)ZTransitionType transitionType;


+ (instancetype)transitionWithType:(ZTransitionType)transitionType;

- (instancetype)initWithTransitionType:(ZTransitionType)transitionType;

@end
