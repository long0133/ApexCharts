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
@property (nonatomic, assign, readonly) CGFloat x; /**<  */
@property (nonatomic, assign, readonly) CGFloat y; /**<  */
@property (nonatomic, assign) CGFloat originX; /**<  */
@property (nonatomic, assign) CGFloat originy; /**<  */
@property (nonatomic, assign, readonly) CGPoint dotCenter; /**<  */

+ (instancetype)ApexDotOnPoint:(ApexPoint*)point type:(ApexDotsType)type;
- (void)setYValue:(NSString*)yValue;
@end

NS_ASSUME_NONNULL_END
