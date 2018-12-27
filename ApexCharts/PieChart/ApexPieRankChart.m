//
//  ApexPieRankChart.m
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/26.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexPieRankChart.h"
#import "ApexPieChart.h"
#import "ApexRankListCell.h"
#import "ApexPieDetailsView.h"
#import "UIView+TKFrame.h"

@interface ApexPieRankChart()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) ApexPieChart *pieChart;
@property (nonatomic,strong) ApexPieDetailsView *detailView;
@property (nonatomic,strong) UITableView *rankTableView;
@property (nonatomic,copy) NSArray *datasArr;
@property (nonatomic,copy) NSArray *titleArr;
@property (nonatomic,copy) NSArray *colorArr;
@property (nonatomic,copy) NSArray *percentageArr;
@property (nonatomic,copy) NSArray *datas;
@end

@implementation ApexPieRankChart

- (instancetype)initWithFrame:(CGRect)frame withDatas:(NSArray <NSNumber *>*)datas withDatasTitle:(NSArray <NSString *>*)dataTitles withColors:(NSArray <UIColor *>*)colors{
    if (self = [super initWithFrame:frame]) {
        _datasArr = [self getPersentArraysWithDataArray:datas];
        _titleArr = dataTitles;
        _colorArr = colors;
        _percentageArr = [self getPercentageBarWidthArrayWithDataArray:_datasArr];
        _datas = datas;
        
        _pieChart = [[ApexPieChart alloc]initWithFrame:CGRectMake(0, 20, 150, 150) withDatas:_datasArr withColors:colors];
        [self addSubview:_pieChart];
        [self addSubview:self.detailView];
        [self addSubview:self.rankTableView];
        
        [self getDetailsDatasIndex:0];
    }return self;
}

#pragma mark - Other Method

//获取排行榜条长度数组
- (NSArray *)getPercentageBarWidthArrayWithDataArray:(NSArray *)datas{
   
    NSArray *newDatas = [datas sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 floatValue] < [obj2 floatValue]) {
                return NSOrderedDescending;
            }else if ([obj1 floatValue] > [obj2 floatValue]){
                return NSOrderedAscending;
            }else{
                return NSOrderedSame;
            }
        }];
    
        NSMutableArray *persentArray = [NSMutableArray array];
        NSNumber *sum = [newDatas valueForKeyPath:@"@sum.floatValue"];
        for (NSNumber *number in newDatas) {
            [persentArray addObject:@(number.floatValue/sum.floatValue)];
    }
    
    float maxV = [newDatas[0] floatValue];
    CGFloat maxW = (self.frame.size.width - 125)/maxV;
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSNumber *num in _datasArr) {
        CGFloat barW = maxW*[num floatValue];
        [mArr addObject:@(barW)];
    }
    return mArr;
}

//获取比例数组
- (NSArray *)getPersentArraysWithDataArray:(NSArray *)datas{
        
    NSMutableArray *persentArray = [NSMutableArray array];
    NSNumber *sum = [datas valueForKeyPath:@"@sum.floatValue"];
    for (NSNumber *number in datas) {
        [persentArray addObject:@(number.floatValue/sum.floatValue)];
    }

    return persentArray;
}

//获取详情
- (void)getDetailsDatasIndex:(NSUInteger)index{
    self.detailView.tipColorLayer.backgroundColor = [(UIColor*)_colorArr[index] CGColor];
    self.detailView.titleLabel.text = _titleArr[index];
    self.detailView.touchNumLabel.text = [NSString stringWithFormat:@"%@",_datas[index]];
    self.detailView.proportionLabel.text = [self getFromNumber:_datasArr[index]];
}

- (NSString *)getFromNumber:(NSNumber *)number{
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 2;
    pFormatter.multiplier = @100.f;
    pFormatter.percentSymbol = @"%";
    NSString *formatterStr = [pFormatter stringFromNumber:number];
    return formatterStr;
}

#pragma mark - TableviewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    ApexRankListCell *rankCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!rankCell) {
        rankCell = [[ApexRankListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    rankCell.elementTitle = _titleArr[indexPath.row];
    rankCell.percentage  = [self getFromNumber:_datasArr[indexPath.row]];
    rankCell.barColor = _colorArr[indexPath.row];
    rankCell.barWidth = [_percentageArr[indexPath.row] floatValue];
    rankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return rankCell;
}

#pragma mark - TableviewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_pieChart shiftAnimationIndexRow:indexPath.row];
    [self getDetailsDatasIndex:indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    backView.backgroundColor = [UIColor colorWithRed:95 green:158 blue:160 alpha:1];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"点击占比排行榜";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:titleLabel];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark - Getter

- (UITableView *)rankTableView{
    if (!_rankTableView) {
        _rankTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, self.bounds.size.width, CGRectGetMaxY(self.frame) - 200)];
        _rankTableView.dataSource = self;
        _rankTableView.delegate = self;
        _rankTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }return _rankTableView;
}

- (ApexPieDetailsView *)detailView{
    if (!_detailView) {
        CGFloat detailViewW = self.frame.size.width/2;
        _detailView = [[ApexPieDetailsView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - detailViewW - 15, 60, detailViewW, 80)];
    }return _detailView;
}

@end
