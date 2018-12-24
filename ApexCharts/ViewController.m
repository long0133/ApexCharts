//
//  ViewController.m
//  ApexCharts
//
//  Created by yulin chi on 2018/12/14.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ViewController.h"
#import "ApexLineChart.h"
#import "UIColor+ChartColor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 250)];
    [self.view addSubview:v];
    
    NSDictionary *seven = @{@"w1":@[@"1,1",@"2,20",@"3,3",@"4,4",@"5,50",@"6,30",@"7,42"]};
    NSDictionary *fifteen = @{@"w1":@[@"1,10",@"2,20",@"3,33",@"4,14",@"5,50",@"6,30",@"7,42",@"8,11",@"9,20",@"10,34",@"11,44",@"12,50",@"13,31",@"14,42",@"15,39"]};
    NSDictionary *fifteen2 = @{@"w1":@[@"1,15",@"2,15",@"3,14",@"4,14",@"5,15",@"6,17",@"7,11",@"8,12",@"9,13",@"10,18",@"11,15",@"12,14",@"13,11",@"14,12"],@"w2":@[@"1,16",@"2,15",@"3,11",@"4,10",@"5,19",@"6,17",@"7,19",@"8,20",@"9,11",@"10,19",@"11,15",@"12,14",@"13,16",@"14,19"]};
    NSDictionary *thirty = @{@"w1":@[@"1,1",@"2,20",@"3,3",@"4,4",@"5,50",@"6,30",@"7,2",@"8,1",@"9,4",@"10,43",@"11,46",@"12,55",@"13,30",@"14,42",@"15,11",@"16,25",@"17,13",@"18,41",@"19,52",@"20,3",@"21,2",@"22,14",@"23,12",@"24,33",@"25,4",@"26,50",@"27,30",@"28,42"]};
    
    ApexLineChart *lineChart = [ApexLineChart showOnView:v WithDatas:fifteen];
    lineChart.lineColorArr = @[UIColorHex(f4e2af),UIColorHex(f0c1e5)];
    lineChart.dotColorArr = @[UIColorHex(1c4ba0),UIColorHex(26a646)];
    lineChart.showXindicatorDashLine = YES;
    
}


@end
