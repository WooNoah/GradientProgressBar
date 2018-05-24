//
//  EvenOddView.m
//  testLayer
//
//  Created by Noah on 2018/5/24.
//  Copyright © 2018年 Noah. All rights reserved.
//

#import "EvenOddView.h"

@implementation EvenOddView

//这里穿插一个知识点：
//一个类的初始化过程，会默认调用InitWithFrame方法
//也就是说如果调用init方法初始化，在[super init]方法中，会默认使用子类的self实例调用父类的initWithFrame:CGRectZero方法，所以就还是会走到initWithFrame方法中，所以我们一般初始化的时候，在initWithFrame方法中操作会更加保险
- (instancetype)init {
    NSLog(@"init");
    if (self = [super init]) {
        //如果还是不放心，那就在init方法中也调用一下同样的操作
        [self testEvenOddLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"initWithFrame");
    if (self = [super initWithFrame:frame]) {
        [self testEvenOddLayer];
    }
    return self;
}

- (void)testEvenOddLayer {
    CAShapeLayer *shapelayer = [CAShapeLayer layer];

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    UIBezierPath *outerCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 4, 4)];
    [outerCircle setLineWidth:2.0];
    [bezierPath appendPath:outerCircle];
    
    UIBezierPath *innerCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 30, 30)];
    [innerCircle setLineWidth:2.0];
    [bezierPath appendPath:innerCircle];
//    bezierPath.usesEvenOddFillRule = YES;
    
    shapelayer.path = bezierPath.CGPath;
    shapelayer.fillRule = @"even-odd";
    shapelayer.fillRule = kCAFillRuleEvenOdd;
    shapelayer.fillColor = [UIColor orangeColor].CGColor;
    shapelayer.strokeColor = [UIColor yellowColor].CGColor;
    shapelayer.opacity = 0.5;
    [self.layer addSublayer:shapelayer];
}

@end
