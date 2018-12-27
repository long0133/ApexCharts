//
//  ApexPieChart.m
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/25.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexPieChart.h"

#define kPieRandColor [UIColor colorWithRed:arc4random() % 255 / 255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.0f]

static CGFloat const kMargin = 20;

static CGFloat const kSectorSpace = 0;

static CGFloat const kOffsetRadius = 10;


@interface ApexPieShaperLayer:CAShapeLayer

@property (nonatomic,assign) CGFloat startAngle;
@property (nonatomic,assign) CGFloat endAngle;
@property (nonatomic,assign) BOOL    isSelected;

@end

@implementation ApexPieShaperLayer


@end

@interface ApexPieChart()

@property (nonatomic,assign) CGPoint pieCenter;
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,strong) CAShapeLayer *maskLayer;
@end

@implementation ApexPieChart

- (instancetype)initWithFrame:(CGRect)frame withDatas:(NSArray <NSNumber *>*)datas withColors:(NSArray <UIColor *>*)colors{
    if (self = [super initWithFrame:frame]) {
        
        _radius = (frame.size.width - kMargin*2)/4.f;
        _pieCenter = CGPointMake(_radius*2 + kMargin, _radius*2 + kMargin);

        [self setMaskLayer];
        [self setDatas:datas colors:colors];
        [self stroke];
    }return self;
}

- (void)setMaskLayer{
    _maskLayer = [CAShapeLayer layer];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:_pieCenter radius:self.bounds.size.width/4.f startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    _maskLayer.strokeColor = [UIColor greenColor].CGColor;
    _maskLayer.lineWidth = self.bounds.size.width/2.f;
    _maskLayer.fillColor = [UIColor clearColor].CGColor;
    _maskLayer.path = maskPath.CGPath;
    _maskLayer.strokeEnd = 0;
    self.layer.mask = _maskLayer;
    
}

- (void)setDatas:(NSArray <NSNumber *>*)datas
          colors:(NSArray <UIColor *>*)colors{
    
    CGFloat start = -M_PI_2;
    CGFloat end = start;

    while (datas.count > self.layer.sublayers.count) {
        ApexPieShaperLayer *pieLayer = [ApexPieShaperLayer layer];
        pieLayer.strokeColor = NULL;
        [self.layer addSublayer:pieLayer];
    }
    
    for (int i = 0; i < self.layer.sublayers.count; i ++) {
        
        ApexPieShaperLayer *pieLayer = (ApexPieShaperLayer *)self.layer.sublayers[i];
        if (i < datas.count) {
            pieLayer.hidden = NO;
            end =  start + M_PI*2*[datas[i] floatValue];
            
            UIBezierPath *piePath = [UIBezierPath bezierPath];
            [piePath moveToPoint:_pieCenter];
            [piePath addArcWithCenter:_pieCenter radius:_radius*2 startAngle:start endAngle:end clockwise:YES];
            
            pieLayer.fillColor = [colors.count > i?colors[i]:kPieRandColor CGColor];
            pieLayer.startAngle = start;
            pieLayer.endAngle = end;
            pieLayer.path = piePath.CGPath;
            
            start = end;
        }else{
            pieLayer.hidden = YES;
        }
    }
}

- (void)stroke{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.f;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_maskLayer addAnimation:animation forKey:@"strokeEnd"];
    
}

- (void)shiftAnimationIndexRow:(NSUInteger)row{
    for (ApexPieShaperLayer *layer in self.layer.sublayers) {
        
        if (row == [self.layer.sublayers indexOfObject:layer] && !layer.isSelected) {
            layer.isSelected = YES;
            CGPoint currPos = layer.position;
            double middleAngle = (layer.startAngle + layer.endAngle)/2.0;
            CGPoint newPos = CGPointMake(currPos.x + kOffsetRadius*cos(middleAngle), currPos.y + kOffsetRadius*sin(middleAngle));
            layer.position = newPos;
            
        }else{
            
            layer.position = CGPointMake(0, 0);
            layer.isSelected = NO;
        }
    }
}


@end
