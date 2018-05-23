//
//  OpenAccountProgressView.m
//  ZJNews
//
//  Created by Noah on 2018/5/23.
//  Copyright © 2018年 FXEYE. All rights reserved.
//

#import "OpenAccountProgressView.h"

///进度条背景色
#define kPVBackgroundColor [UIColor colorWithRed:237/255.0 green:244/255.0 blue:254/255.0 alpha:1]

///半径偏差量
//static const CGFloat radiusOffset = 2.5;
//默认半径就是上层渐变层头部圆的半径
//半径偏差量就是上层渐变层头部圆与底层进度条圆角的差值
#define kPVRadiusOffSet 2.5

@interface OpenAccountProgressView()
///渐变层
@property (strong, nonatomic) CAShapeLayer *gradientLayer;
///底部层
@property (strong, nonatomic) CAShapeLayer *backLayer;
///最上面小圆层
@property (strong, nonatomic) CAShapeLayer *circleLayer;

@end


@implementation OpenAccountProgressView
{
    ///view的宽
    CGFloat _frameW;
    ///view的高
    CGFloat _frameH;
    ///大圆的半径
    CGFloat _bigRadius;
    ///小圆的半径
    CGFloat _smallRadius;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupLayers];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupLayers];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLayers];
    }
    return self;
}


- (void)setupLayers {
    self.backLayer = [CAShapeLayer layer];
    self.backLayer.fillColor = kPVBackgroundColor.CGColor;
    UIBezierPath *backPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, kPVRadiusOffSet, _frameW, _smallRadius*2) cornerRadius: _smallRadius];
    self.backLayer.path = backPath.CGPath;
    [self.layer addSublayer:self.backLayer];
    
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    _frameW = layer.frame.size.width;
    _frameH = layer.frame.size.height;
    _bigRadius = _frameH/2;
    _smallRadius = _bigRadius - kPVRadiusOffSet;
    
    [self setupLayers];
    self.progress = _progress;
}


- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    CGFloat currentX = _frameW * progress/100;
    
    self.gradientLayer = [CAShapeLayer layer];
    self.gradientLayer.fillColor = [UIColor yellowColor].CGColor;
    UIBezierPath *colorPath = [UIBezierPath bezierPath];
    [colorPath moveToPoint:CGPointMake(0, _bigRadius)];
    [colorPath addArcWithCenter:CGPointMake(_smallRadius, _bigRadius) radius:_smallRadius startAngle:M_PI endAngle:3*M_PI_2 clockwise:YES];
    [colorPath addLineToPoint:CGPointMake(currentX-20-2, kPVRadiusOffSet)];
    //405 - 385 = 20px 的曲线
    //二阶曲线
//    [colorPath addQuadCurveToPoint:CGPointMake(currentX - 2, 0) controlPoint:CGPointMake(currentX - 10, kPVRadiusOffSet)];
//    [colorPath addLineToPoint:CGPointMake(currentX, 0)];
//    [colorPath addArcWithCenter:CGPointMake(currentX, bigRadius) radius:bigRadius startAngle:3*M_PI_2 endAngle:5*M_PI_2 clockwise:YES];
//    [colorPath addLineToPoint:CGPointMake(currentX - 2, frameH)];
//    [colorPath addQuadCurveToPoint:CGPointMake(currentX - 20 - 2, frameH - kPVRadiusOffSet) controlPoint:CGPointMake(currentX - 10, frameH - kPVRadiusOffSet)];
    //三阶曲线
    [colorPath addCurveToPoint:CGPointMake(currentX, 0) controlPoint1:CGPointMake(currentX - 15, kPVRadiusOffSet) controlPoint2:CGPointMake(currentX - 5, 0)];
    [colorPath addArcWithCenter:CGPointMake(currentX, _bigRadius) radius:_bigRadius startAngle:3*M_PI_2 endAngle:5*M_PI_2 clockwise:YES];
    [colorPath addCurveToPoint:CGPointMake(currentX - 20, _frameH - kPVRadiusOffSet) controlPoint1:CGPointMake(currentX - 5, _frameH) controlPoint2:CGPointMake(currentX - 15, _frameH - kPVRadiusOffSet)];
    
    [colorPath addLineToPoint:CGPointMake(_smallRadius, _frameH - kPVRadiusOffSet)];
    [colorPath addArcWithCenter:CGPointMake(_smallRadius, _bigRadius) radius:_smallRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    colorPath.flatness = 0.6;
    [colorPath closePath];
    self.gradientLayer.path = colorPath.CGPath;
    
    //渐变色layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:76/255.0 green:194/255.0 blue:255/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:75/255.0 green:137/255.0 blue:230/255.0 alpha:1].CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, currentX+_bigRadius, _frameH);
    gradientLayer.mask = self.gradientLayer;
    [self.layer addSublayer:gradientLayer];
    
    
    //进度条头部圆形layer
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.fillColor = kPVBackgroundColor.CGColor;
//    self.circleLayer.fillColor = kPVBackgroundColor.CGColor;
    //圆心    (frameW * progress/100,bigRadius)
    //起始点   (frameW * progress/100 - smallRadius, bigRadisu)
    //因为使用了三次曲线，所以圆心偏移1px
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:CGPointMake(currentX - _smallRadius, _bigRadius)];
    [circlePath addArcWithCenter:CGPointMake(_frameW * progress/100 - 1, _bigRadius) radius:_smallRadius startAngle:M_PI endAngle:M_PI*3 clockwise:YES];
    self.circleLayer.path = circlePath.CGPath;
    [self.layer addSublayer:self.circleLayer];
}

@end
