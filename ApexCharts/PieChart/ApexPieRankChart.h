//
//  ApexPieRankChart.h
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/26.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApexPieRankChart : UIView

/**
 绘制饼图+排行榜
 @param frame frame
 @param datas 点击量数据
 @param dataTitles 事件元素标题(要和datas数据一一对应)
 @param colors 对应颜色
 */
- (instancetype)initWithFrame:(CGRect)frame withDatas:(NSArray <NSNumber *>*)datas withDatasTitle:(NSArray <NSString *>*)dataTitles withColors:(NSArray <UIColor *>*)colors;
@end

NS_ASSUME_NONNULL_END
