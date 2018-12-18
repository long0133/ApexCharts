//
//  ApexLineChart.m
//  ApexCharts
//
//  Created by yulin chi on 2018/12/14.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexLineChart.h"
#import "UIView+TKFrame.h"
#import "CALayer+TKFrame.h"
#import "ApexPoint.h"
#import "ApexLine.h"
#import "ApexDot.h"

#define axisLineWidth 2
#define axisColor [UIColor grayColor]
#define yScaleSubtle 0.5  //y轴拉伸的调节

@interface ApexLineChart ()
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSArray<ApexPoint*>*> *lines; /**<  */
@property (nonatomic, strong) CALayer *canvasLayer; /**<  */
@property (nonatomic, strong) CAShapeLayer *x; /**<  */
@property (nonatomic, strong) CAShapeLayer *y; /**<  */
@property (nonatomic, assign) NSInteger xDotCount; /**<  */
@property (nonatomic, assign) NSInteger yDotCount; /**<  */
@property (nonatomic, assign) CGFloat xDelta; /**<  */
@property (nonatomic, assign) CGFloat yDelta; /**<  */
@property (nonatomic, assign) CGFloat yScale; /**<  */
@property (nonatomic, assign) CGFloat maxX; /**<  */
@property (nonatomic, assign) CGFloat maxY; /**<  */
@property (nonatomic, strong) NSMutableArray *xDotArr; /**< 数据原始x值的数组 */
@property (nonatomic, strong) NSMutableArray<NSValue*> *xAxisPointsArr; /**< x坐标轴上点的集合 */
@property (nonatomic, strong) ApexLine *anyLine; /**<  */
@end

@implementation ApexLineChart

+ (instancetype)showOnView:(UIView *)view WithDatas:(NSDictionary<NSString *,NSArray *> *)datas{
    
    ApexLineChart *lineChart = [[ApexLineChart alloc] initWithFrame:view.bounds];
    [lineChart prepareDatas:datas];
    [view addSubview:lineChart];
    return lineChart;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.layer addSublayer:self.canvasLayer];
    [self drawXAxis];
    [self drawYAxis];
}

- (void)drawXAxis{
    UIBezierPath *xAxis = [[UIBezierPath alloc] init];
    [xAxis moveToPoint:CGPointMake(0, self.canvasLayer.bottom)];
    [xAxis addLineToPoint:CGPointMake(self.canvasLayer.width, self.canvasLayer.bottom)];
    self.x.path = xAxis.CGPath;
    [self.canvasLayer addSublayer:self.x];
}

- (void)drawYAxis{
    UIBezierPath *yAxis = [[UIBezierPath alloc] init];
    [yAxis moveToPoint:CGPointMake(0, self.canvasLayer.bottom)];
    [yAxis addLineToPoint:CGPointMake(0, 0)];
    self.y.path = yAxis.CGPath;
    //隐藏y轴
//    [self.canvasLayer addSublayer:self.y];
}

#pragma mark - setter
- (void)prepareDatas:(NSDictionary<NSString *,NSArray *> *)datas{
    
    @try {
        for (NSString *key in datas.allKeys) {
            NSArray *linePoints = datas[key];
            NSMutableArray<ApexPoint*> *temp = [NSMutableArray array];
            [linePoints enumerateObjectsUsingBlock:^(NSString *pt, NSUInteger idx, BOOL * _Nonnull stop) {
                CGPoint p = CGPointFromString([NSString stringWithFormat:@"{%@}",pt]);
                [temp addObject:[ApexPoint apexPointWithPoint:p]];
            }];
            [self.lines setObject:temp forKey:key];
        }
    } @catch (NSException *exception) {
        
    }
    
    
    [self dotCount];
    [self drawXDots];
    [self drawYDots];
    [self drawLine];
    [self drawXtag];
}

- (void)drawXDots{
    CGFloat interval = self.canvasLayer.right / (self.xDotCount + 1);
    _xDelta = interval;
    for (NSInteger i = 0; i < self.xDotCount; i++) {
        CAShapeLayer *xDot = [[CAShapeLayer alloc] init];
        xDot.strokeColor = axisColor.CGColor;
        xDot.lineWidth = axisLineWidth;
        
        CGPoint p = CGPointMake(i * interval, self.canvasLayer.bottom);
        [self.xAxisPointsArr addObject:[NSValue valueWithCGPoint:p]];
        
        UIBezierPath *dotPath = [UIBezierPath bezierPath];
        [dotPath moveToPoint:p];
        [dotPath addLineToPoint:CGPointMake(p.x, p.y - 4)];
        xDot.path = dotPath.CGPath;
        
        [self.canvasLayer addSublayer:xDot];
    }
}

- (void)drawYDots{
    CGFloat interval = self.canvasLayer.height / (self.yDotCount + 1);
    _yDelta = self.maxY / (self.yDotCount + 1);
    _yScale = (interval / _yDelta) * yScaleSubtle;
    for (NSInteger i = 0; i <= self.yDotCount; i++) {
        CAShapeLayer *yDot = [[CAShapeLayer alloc] init];
        yDot.strokeColor = axisColor.CGColor;
        yDot.lineWidth = axisLineWidth;
        
        UIBezierPath *dotPath = [UIBezierPath bezierPath];
        [dotPath moveToPoint:CGPointMake(0, self.canvasLayer.height - (i * interval))];
        [dotPath addLineToPoint:CGPointMake(4, self.canvasLayer.height - (i * interval))];
        yDot.path = dotPath.CGPath;
        
        //隐藏y的点
//        [self.canvasLayer addSublayer:yDot];
    }
}

- (void)drawXtag{
    for (NSInteger i = 0; i < self.xDotCount; i++) {
        UILabel *tagL = [[UILabel alloc] init];
        tagL.frame = CGRectMake(i * _xDelta + 15, self.canvasLayer.bottom + 5, 15, 20);
        tagL.font = [UIFont systemFontOfSize:11];
        tagL.textColor = [UIColor blackColor];
        NSNumber *xNumber = self.xDotArr[i];
        tagL.text = [NSString stringWithFormat:@"%ld",xNumber.integerValue];
        [self addSubview:tagL];
    }
}

- (void)drawLine{
    @try {
        NSInteger i = 0;
        
        for (NSString *key in self.lines) {
            
            ApexLine *line = [ApexLine apexLineWithPoints:self.lines[key] onLayer:self.canvasLayer xDelta:_xDelta yDelta:_yDelta yScale:_yScale];
            
            if (line.dots.count > 20) {
                line.shouldShowYValue = false;
            }
            
            if (!_anyLine || _anyLine.dots.count < line.dots.count) {
                _anyLine = line;
            }
            
            if (i < self.lineColorArr.count && i < self.dotColorArr.count) {
                line.lineColor = self.lineColorArr[i];
                line.dotColor = self.dotColorArr[i];
            }
            
            i ++;
        }
    } @catch (NSException *exception) {
    }
}

- (void)setShowXindicatorDashLine:(BOOL)showXindicatorDashLine{
    _showXindicatorDashLine = showXindicatorDashLine;
    
    if (showXindicatorDashLine) {
        @try {
            
            [_anyLine.dots enumerateObjectsUsingBlock:^(ApexDot * _Nonnull dot, NSUInteger idx, BOOL * _Nonnull stop) {
                CGPoint xPoint = self.xAxisPointsArr[idx].CGPointValue;
                
                CAShapeLayer *dashLineLayer = [[CAShapeLayer alloc] init];
                dashLineLayer.lineWidth = 2;
                dashLineLayer.fillColor = [UIColor grayColor].CGColor;
                dashLineLayer.strokeColor = [UIColor grayColor].CGColor;
                dashLineLayer.lineDashPattern = @[@(3),@(5)];
                
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path moveToPoint:xPoint];
                [path addLineToPoint:dot.dotCenter];
                
                dashLineLayer.path = path.CGPath;
                [self.canvasLayer addSublayer:dashLineLayer];
            }];
            
        } @catch (NSException *exception) {
            
        }
    }
}

#pragma mark - setter
- (void)setLineColorArr:(NSArray *)lineColorArr{
    _lineColorArr = lineColorArr;
    
    [self drawLine];
}

- (void)setDotColorArr:(NSArray *)dotColorArr{
    _dotColorArr = dotColorArr;
    
    [self drawLine];
}

#pragma mark - getter
- (void)dotCount{
    _xDotCount = 1;
    __block CGFloat maxX = 1;
    __block CGFloat maxY = 1;
    
    NSMutableSet *XcountSet = [NSMutableSet set];
    NSMutableSet *YcountSet = [NSMutableSet set];
    _xDotArr = [NSMutableArray array];
    
    for (NSString *key in self.lines.allKeys) {
        NSArray *arr = self.lines[key];
        [arr enumerateObjectsUsingBlock:^(ApexPoint *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.x >= maxX) {
                maxX = obj.x;
            }
            if (obj.y >= maxY) {
                maxY = obj.y;
            }
            
            [XcountSet addObject:@(obj.x)];
            [YcountSet addObject:@(obj.y)];
            [self.xDotArr addObject:@(obj.x)];
        }];
    }
     _maxX = maxX;
     _maxY = maxY;
    _xDotCount = XcountSet.count;
    _yDotCount = YcountSet.count;
}


- (CALayer *)canvasLayer{
    if (!_canvasLayer) {
        _canvasLayer = [[CALayer alloc] init];
        _canvasLayer.frame = CGRectMake(20, 0, self.width-30, self.height-20);
    }
    return _canvasLayer;
}

- (CAShapeLayer *)x{
    if (!_x) {
        _x = [[CAShapeLayer alloc] init];
        _x.strokeColor = axisColor.CGColor;
        _x.fillColor = [UIColor clearColor].CGColor;
        _x.lineCap = kCALineCapRound;
        _x.lineWidth = axisLineWidth;
    }
    return _x;
}

- (CAShapeLayer *)y{
    if (!_y) {
        _y = [[CAShapeLayer alloc] init];
        _y.strokeColor = axisColor.CGColor;
        _y.fillColor = [UIColor clearColor].CGColor;
        _y.lineCap = kCALineCapRound;
        _y.lineWidth = axisLineWidth;
    }
    return _y;
}

- (NSMutableDictionary<NSString *,NSArray<ApexPoint *> *> *)lines{
    if (!_lines) {
        _lines = [NSMutableDictionary dictionary];
    }
    return _lines;
}

- (NSMutableArray<NSValue *> *)xAxisPointsArr{
    if (!_xAxisPointsArr) {
        _xAxisPointsArr = [NSMutableArray array];
    }
    return _xAxisPointsArr;
}
@end
