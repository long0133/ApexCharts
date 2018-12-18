//
//  ApexPoint.h
//  ApexCharts
//
//  Created by yulin chi on 2018/12/17.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ApexPoint : NSObject
@property (nonatomic, assign) CGFloat x; /**<  */
@property (nonatomic, assign) CGFloat y; /**<  */

+ (instancetype)apexPointWithX:(CGFloat)x Y:(CGFloat)y;
+ (instancetype)apexPointWithPoint:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
