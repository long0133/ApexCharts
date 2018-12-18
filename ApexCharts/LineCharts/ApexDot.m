//
//  ApexDot.m
//  ApexCharts
//
//  Created by yulin chi on 2018/12/17.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexDot.h"
#import "ApexPoint.h"
#import "UIView+TKFrame.h"
#import "UIColor+ChartColor.h"

#define Kwidth 40
#define Kheight 40
#define dotScale 4
#define DotColor [UIColor colorWithHexString:@"f86da1"]
#define labelColor [UIColor colorWithHexString:@"f86da1"]

@interface ApexDot ()
@property (nonatomic, assign) ApexDotsType type; /**<  */
@property (nonatomic, strong) CAShapeLayer *dotLayer; /**<  */
@property (nonatomic, strong) UILabel *yLabel; /**<  */
@end

@implementation ApexDot
+ (instancetype)ApexDotOnPoint:(ApexPoint *)point type:(ApexDotsType)type{
    ApexDot *dot = [[ApexDot alloc] init];
    dot.type = type;
    [dot prepareDot:point];
    return dot;
}

- (void)prepareDot:(ApexPoint*)point{

    _dotCenter = CGPointMake(point.x, point.y);
    _x = _dotCenter.x - Kwidth / 2.0;
    _y = _dotCenter.y;
    self.frame = CGRectMake(_x, _y - Kheight, Kwidth, Kheight);
    self.layer.anchorPoint = CGPointMake(0.5, 1);
    
    CGFloat dotWidth = self.width/dotScale;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.width/2.0 - dotWidth/2.0, self.height - dotWidth/2.0, dotWidth, dotWidth)];
    self.dotLayer.path = path.CGPath;
    [self.layer addSublayer:self.dotLayer];
    
    self.yLabel.frame = CGRectMake(0, self.height/4, self.width, self.height - dotWidth);
    self.yLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.yLabel];
}

- (void)setYValue:(NSString *)yValue{
    self.yLabel.text = yValue;
}
#pragma mark - getter
- (CAShapeLayer *)dotLayer{
    if (!_dotLayer) {
        _dotLayer = [[CAShapeLayer alloc] init];
        _dotLayer.fillColor = DotColor.CGColor;
        _dotLayer.lineWidth = 2;
        _dotLayer.strokeColor = DotColor.CGColor;
    }
    return _dotLayer;
}

- (UILabel *)yLabel{
    if (!_yLabel) {
        _yLabel = [[UILabel alloc] init];
        [_yLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:11]];
        _yLabel.textColor = labelColor;
        [_yLabel adjustsFontSizeToFitWidth];
    }
    return _yLabel;
}
@end
