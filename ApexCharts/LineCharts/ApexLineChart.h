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
+ (void)showOnView:(UIView *)view WithDatas:(NSDictionary<NSString *,NSArray *> *)datas;
@end

NS_ASSUME_NONNULL_END
