//
//  UIColor+ChartColor.h
//  ApexCharts
//
//  Created by yulin chi on 2018/12/18.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

@interface UIColor (ChartColor)
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
