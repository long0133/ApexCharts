//
//  ApexPieChart.h
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/25.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApexPieChart : UIView
- (instancetype)initWithFrame:(CGRect)frame withDatas:(NSArray <NSNumber *>*)datas withColors:(NSArray <UIColor *>*)colors;
- (void)shiftAnimationIndexRow:(NSUInteger)row;
@end

NS_ASSUME_NONNULL_END
