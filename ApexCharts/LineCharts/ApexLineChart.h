//
//  ApexLineChart.h
//  ApexCharts
//
//  Created by yulin chi on 2018/12/14.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApexLineChart : UIView
//颜色配置
@property (nonatomic, strong) NSArray *lineColorArr; /**<  */
@property (nonatomic, strong) NSArray *dotColorArr; /**<  */

@property (nonatomic, assign) BOOL showXindicatorDashLine; /**<  */


/**
 绘制折线图
 @param view 父view
 @param datas 点的x,y数据
 @param detailData 点击点时显示的详细数据 需要d与data一一对应
 */
+ (instancetype)showOnView:(UIView *)view WithDatas:(NSDictionary<NSString *,NSArray *> *)datas detailData:(NSDictionary<NSString *,NSArray *> *)detailData;
@end

NS_ASSUME_NONNULL_END
