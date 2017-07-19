//
//  TelephoneViewController.m
//  拖拽控件
//
//  Created by YYKit on 2017/6/12.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "TelephoneViewController.h"
#import "ViewController.h"
#import "ZTransition.h"
@interface TelephoneViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation TelephoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Dismiss");


    UIToolbar *tools = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:tools];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.transitioningDelegate = self;
        self.modalTransitionStyle = UIModalPresentationCustom;
    }
    return self;
}

- (IBAction)dismissVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [ZTransition transitionWithType:ZTransitionTypeShow];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [ZTransition transitionWithType:ZTransitionTypeDismiss];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
