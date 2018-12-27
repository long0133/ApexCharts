//
//  ApexRankListCell.h
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/26.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApexRankListCell : UITableViewCell
@property (nonatomic,copy) NSString *elementTitle;
@property (nonatomic,copy) NSString *percentage;
@property (nonatomic,strong) UIColor *barColor;
@property (nonatomic,assign) CGFloat barWidth;
@end

NS_ASSUME_NONNULL_END
