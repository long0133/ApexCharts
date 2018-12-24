//
//  ApexDot.h
//  ApexCharts
//
//  Created by yulin chi on 2018/12/17.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@class ApexPoint;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ApexDotsType) {
    ApexDotsTypeTriangle,
    ApexDotsTypeCubic,
    ApexDotsTypeCircle,
    ApexDotsTypeDot
};


@interface ApexDot : UIView
@property (nonatomic, assign, readonly) CGFloat x; /**< 在视图中的点的x */
@property (nonatomic, assign, readonly) CGFloat y; /**< 在视图中的点的y */
//@property (nonatomic, assign) CGFloat originX; /**< 数据中原本的x */
@property (nonatomic, assign) CGFloat originy; /**< 数据中原本的y */
@property (nonatomic, assign, readonly) CGPoint dotCenter; /**<  */
@property (nonatomic, assign) BOOL shouldShowYValue; /**<  */
@property (nonatomic, strong) UIColor *dotColor; /**<  */

@property (nonatomic, assign) NSInteger index; /**<  */
@property (nonatomic, copy) void (^didClickDot)(NSInteger index);

+ (instancetype)ApexDotOnPoint:(ApexPoint*)point type:(ApexDotsType)type;
- (void)setYValue:(NSString*)yValue;
@end

NS_ASSUME_NONNULL_END
