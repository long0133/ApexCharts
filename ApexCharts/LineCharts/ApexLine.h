//
//  ApexLine.h
//  ApexCharts
//
//  Created by yulin chi on 2018/12/17.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class ApexPoint;

NS_ASSUME_NONNULL_BEGIN

@interface ApexLine : CALayer
+ (instancetype)apexLineWithPoints:(NSArray<ApexPoint *> *)points onLayer:(CALayer *)superLayer xDelta:(CGFloat)xDelta yDelta:(CGFloat)yDelta yScale:(CGFloat)yScale;
@end

NS_ASSUME_NONNULL_END
