//
//  ApexPieDetailsView.m
//  ApexCharts
//
//  Created by 马晨曦 on 2018/12/27.
//  Copyright © 2018 yulin chi. All rights reserved.
//

#import "ApexPieDetailsView.h"
#import "UIView+TKFrame.h"
#import "CALayer+TKFrame.h"

static CGFloat const kMargin = 15;

@interface ApexPieDetailsView()
@property (nonatomic,strong) CALayer *lineLayerH;
@property (nonatomic,strong) CALayer *lineLayerV;
@property (nonatomic,strong) UILabel *touchTilLabel;
@property (nonatomic,strong) UILabel *proportionTilLabel;
@end

@implementation ApexPieDetailsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }return self;
}
- (void)createUI{
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    
    CALayer *tipColorLayer = [CALayer layer];
    [self.layer addSublayer:tipColorLayer];
    self.tipColorLayer = tipColorLayer;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    CALayer *lineLayerH = [CALayer layer];
    lineLayerH.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:lineLayerH];
    self.lineLayerH = lineLayerH;

    CALayer *lineLayerV = [CALayer layer];
    lineLayerV.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:lineLayerV];
    self.lineLayerV = lineLayerV;

    UILabel *touchTilLabel = [[UILabel alloc]init];
    touchTilLabel.text = @"点击量";
    touchTilLabel.font = [UIFont systemFontOfSize:13];
    touchTilLabel.textColor = [UIColor grayColor];
    [self addSubview:touchTilLabel];
    self.touchTilLabel = touchTilLabel;

    UILabel *touchNumLabel = [[UILabel alloc]init];
    touchNumLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:touchNumLabel];
    self.touchNumLabel = touchNumLabel;

    UILabel *proportionTilLabel = [[UILabel alloc]init];
    proportionTilLabel.text = @"点击占比";
    proportionTilLabel.font = [UIFont systemFontOfSize:13];
    proportionTilLabel.textColor = [UIColor grayColor];
    [self addSubview:proportionTilLabel];
    self.proportionTilLabel = proportionTilLabel;

    UILabel *proportionLabel = [[UILabel alloc]init];
    proportionLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:proportionLabel];
    self.proportionLabel = proportionLabel;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat tipColW = 20;
    self.tipColorLayer.frame = CGRectMake(kMargin, (self.height/3 - tipColW)/2, tipColW, tipColW);
    self.titleLabel.frame = CGRectMake(kMargin*2 + tipColW, (self.height/3 - tipColW)/2, self.width - kMargin*2 - tipColW, tipColW);
    self.lineLayerH.frame = CGRectMake(0, self.height/3, self.width, 1);
    self.lineLayerV.frame = CGRectMake(self.width/2 - 0.5, self.height/3 + 1, 1, (self.height/3)*2 - 1);
    self.touchTilLabel.frame = CGRectMake(kMargin, CGRectGetMaxY(self.lineLayerH.frame)+5, self.width/2 - kMargin, 20);
    self.touchNumLabel.frame = CGRectMake(kMargin, CGRectGetMaxY(self.touchTilLabel.frame), self.width/2-kMargin, 20);
    self.proportionTilLabel.frame = CGRectMake(CGRectGetMaxX(self.lineLayerV.frame) + kMargin, CGRectGetMaxY(self.lineLayerH.frame)+5, self.width/2 - kMargin, 20);
    self.proportionLabel.frame = CGRectMake(CGRectGetMaxX(self.lineLayerV.frame) + kMargin, CGRectGetMaxY(self.proportionTilLabel.frame), self.width/2 - kMargin, 20);

}

@end
