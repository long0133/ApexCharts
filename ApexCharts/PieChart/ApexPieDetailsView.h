//
//  ApexPieDetailsView.h
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/27.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApexPieDetailsView : UIView
@property (nonatomic,strong) CALayer *tipColorLayer; //提示颜色
@property (nonatomic,strong) UILabel *titleLabel; //元素事件名称
@property (nonatomic,strong) UILabel *touchNumLabel; //点击量
@property (nonatomic,strong) UILabel *proportionLabel; //点击占比
@end

NS_ASSUME_NONNULL_END

