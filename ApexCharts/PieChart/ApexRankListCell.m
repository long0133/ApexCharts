//
//  ApexRankListCell.m
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/26.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexRankListCell.h"
#import "UIView+TKFrame.h"
@interface ApexRankListCell()
@end

@implementation ApexRankListCell

- (void)drawRect:(CGRect)rect{
    
    CGFloat kMargin = 15;
    CGFloat titleW = 80;
    
    {
        UIFont *titleFont = [UIFont systemFontOfSize:15];
        NSDictionary *attrs = @{NSFontAttributeName : titleFont};
        [self.elementTitle drawInRect:CGRectMake(kMargin, (self.height-15)/2, titleW, self.height) withAttributes:attrs];
    }
    
    {
        UIFont *percentageFont = [UIFont systemFontOfSize:10];
        NSDictionary * attrs = @{NSFontAttributeName : percentageFont,NSForegroundColorAttributeName : [UIColor grayColor]};
        [self.percentage drawInRect:CGRectMake(titleW + kMargin*2, 8, 50, 11) withAttributes:attrs];
    }
    
    {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(titleW + kMargin*2, 20, _barWidth, 13);
        layer.backgroundColor = self.barColor.CGColor;
        [self.contentView.layer addSublayer:layer];
        
    }
}

@end
