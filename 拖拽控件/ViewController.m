//
//  ViewController.m
//  拖拽控件
//
//  Created by YYKit on 2017/6/9.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "ViewController.h"
#import "TelephoneViewController.h"
@interface ViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication].keyWindow setBackgroundColor:[UIColor lightGrayColor]];


//    self.icon = [[UIImageView alloc]init];
//    self.icon.frame = CGRectMake(100, 100, 60, 60);
//    self.icon.image = [UIImage imageNamed:@"phone (1)"];
//    [self.view addSubview:self.icon];


//    self.imageView.layer.masksToBounds = YES;
//    self.imageView.layer.cornerRadius = 30.0f;
    self.imageView.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;

    //TODO:手势1
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                          action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    panGestureRecognizer.cancelsTouchesInView = NO;
    [self.imageView addGestureRecognizer:panGestureRecognizer];

    //TODO:手势2
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(show)];
    tap.cancelsTouchesInView = NO;
    [self.imageView addGestureRecognizer:tap];

}

- (void)show
{
    TelephoneViewController *telephone = [[TelephoneViewController alloc]init];
    [self presentViewController:telephone animated:YES completion:nil];
}

#pragma mark 手势执行方法
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{

    CGPoint translation     = [recognizer translationInView:self.imageView];
    CGPoint viewNewPoint    = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);

    //TODO:给拖拽控件设置范围
    viewNewPoint.y          = MAX((recognizer.view.frame.size.height)/2 + 64, viewNewPoint.y);//y的最小值
    viewNewPoint.y          = MIN(self.view.frame.size.height - recognizer.view.frame.size.height/2 - 49,  viewNewPoint.y);//y的最大值
    viewNewPoint.x          = MAX(recognizer.view.frame.size.width/2, viewNewPoint.x);
    viewNewPoint.x          = MIN(self.view.frame.size.width - recognizer.view.frame.size.width/2,viewNewPoint.x);
    recognizer.view.center  = viewNewPoint;
    [recognizer setTranslation:CGPointZero inView:self.imageView];
}


- (CGRect)roundFrame
{
    return _imageView.frame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
