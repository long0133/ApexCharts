//
//  ApexLine.h
//  ApexCharts
//
//  Created by yulin chi on 2018/12/17.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@class ApexPoint;
@class ApexDot;

NS_ASSUME_NONNULL_BEGIN

@interface ApexLine : UIView
@property (nonatomic, strong, readonly) NSArray<ApexDot*> *dots; /**<  */
@property (nonatomic, assign) BOOL shouldShowYValue; /**<  */

@property (nonatomic, strong) UIColor *lineColor; /**<  */
@property (nonatomic, strong) UIColor *dotColor; /**<  */

+ (instancetype)apexLineWithPoints:(NSArray<ApexPoint *> *)points onLayer:(UIView *)superView xDelta:(CGFloat)xDelta yDelta:(CGFloat)yDelta yScale:(CGFloat)yScale;
@end

NS_ASSUME_NONNULL_END
