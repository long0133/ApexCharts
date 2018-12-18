//
//  ApexPoint.m
//  ApexCharts
//
//  Created by yulin chi on 2018/12/17.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexPoint.h"

@implementation ApexPoint
+ (instancetype)apexPointWithX:(CGFloat)x Y:(CGFloat)y{
    ApexPoint *p = [[ApexPoint alloc] init];
    p.x = x;
    p.y = y;
    return p;
}

+ (instancetype)apexPointWithPoint:(CGPoint)point{
    return [ApexPoint apexPointWithX:point.x Y:point.y];
}
@end
