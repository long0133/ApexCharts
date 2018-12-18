//
//  ApexLine.m
//  ApexCharts
//
//  Created by yulin chi on 2018/12/17.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexLine.h"
#import "ApexPoint.h"
#import "ApexDot.h"
#import "CALayer+TKFrame.h"
#import "UIColor+ChartColor.h"

@interface ApexLine ()
@property (nonatomic, strong) CAShapeLayer *line; /**<  */
@property (nonatomic, assign) CGFloat xDelta; /**<  */
@property (nonatomic, assign) CGFloat yDelta; /**<  */
@property (nonatomic, assign) CGFloat yScale; /**<  */
@property (nonatomic, strong) ApexDot *lastDot; /**<  */
@end

@implementation ApexLine

+ (instancetype)apexLineWithPoints:(NSArray<ApexPoint *> *)points onLayer:(CALayer *)superLayer xDelta:(CGFloat)xDelta yDelta:(CGFloat)yDelta yScale:(CGFloat)yScale{
    ApexLine *line = [[ApexLine alloc] init];
    line.frame = superLayer.bounds;
    line.xDelta = xDelta;
    line.yDelta = yDelta;
    line.yScale = yScale;
    [line drawLine:points];
    [superLayer addSublayer:line];
    return line;
}

- (void)drawLine:(NSArray<ApexPoint*>*)points{
    NSMutableArray *temp = [NSMutableArray array];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [points enumerateObjectsUsingBlock:^(ApexPoint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //数据中的点转化为视图中的点
        CGFloat x = (idx) * self.xDelta;
        CGFloat y = (self.height - ((obj.y) * self.yScale));
    
        CGFloat originX = obj.x;
        CGFloat originY = obj.y;
        
        obj = [ApexPoint apexPointWithX:x Y:y];
        ApexDot *dot = [ApexDot ApexDotOnPoint:obj type:ApexDotsTypeCircle];
        dot.originX = originX;
        dot.originy = originY;
        [dot setYValue:[NSString stringWithFormat:@"%.1f",originY]];
        
        if (idx == 0) {
            [path moveToPoint:dot.center];
        }else{
            [path addLineToPoint:dot.center];
        }
        
        self.lastDot = dot;
        [temp addObject:dot];
    }];
    
    _dots = [temp copy];
    self.line.path = path.CGPath;
    [self addSublayer:self.line];
    
    [self.dots enumerateObjectsUsingBlock:^(ApexDot * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSublayer:obj.layer];
    }];
}

#pragma mark - getter
- (void)setShouldShowYValue:(BOOL)shouldShowYValue{
    _shouldShowYValue = shouldShowYValue;
    
    [self.dots enumerateObjectsUsingBlock:^(ApexDot * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.shouldShowYValue = shouldShowYValue;
    }];
}

- (void)setDotColor:(UIColor *)dotColor{
    _dotColor = dotColor;
    [self.dots enumerateObjectsUsingBlock:^(ApexDot * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.dotColor = dotColor;
    }];
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.line.strokeColor = lineColor.CGColor;
    [self setNeedsDisplay];
}

- (CAShapeLayer *)line {
    if (!_line) {
        _line = [[CAShapeLayer alloc] init];
        _line.lineWidth = 2;
        _line.fillColor = [UIColor clearColor].CGColor;
        _line.strokeColor = UIColorHex(8ec7a1).CGColor;
        _line.lineJoin = kCALineJoinRound;
    }
    return _line;
}
@end
