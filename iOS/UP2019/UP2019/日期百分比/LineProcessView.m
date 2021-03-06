//
//  LineProcessView.m
//  UP2019
//
//  Created by Yunis on 2019/3/12.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "LineProcessView.h"
@interface LineProcessView()
{
    CAShapeLayer* _layer;
    UIBezierPath* bezierPath;


}
@end
@implementation LineProcessView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupView];
}

-(void)setupView{

    
    bezierPath = [[UIBezierPath alloc]init];
    _layer = [CAShapeLayer layer];
    
    _layer.fillColor = [UIColor yellowColor].CGColor;
    _layer.strokeColor = RGBA(33, 178, 123, 1).CGColor;
    _layer.lineCap = @"round";//圆角
    [self.layer addSublayer:_layer];

    
    self.clipsToBounds = YES;
    self.backgroundColor = RGBA(216, 216, 216, 1);
}

-(void)setProcessValue:(float)processValue{
    
    _processValue= processValue;
    
    _layer.strokeEnd= processValue;
    
}

-(void)setFillColor:(UIColor*)fillColor{
    
    _fillColor= fillColor;
    
    _layer.strokeColor = _fillColor.CGColor;
    
}

-(void)setDefaultColor:(UIColor*)defaultColor{
    
    _defaultColor= defaultColor;
    
    self.backgroundColor= defaultColor;
    
}

//支持 autoLayout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width =self.bounds.size.width;
    
    CGFloat height = self.bounds.size.height;
    
    [bezierPath moveToPoint:CGPointMake(0, height/2)];
    [bezierPath addLineToPoint:CGPointMake(width, height/2)];
    
    _layer.path= bezierPath.CGPath;
//    _layer.strokeEnd = 0.0;
    _layer.lineWidth = height;//线宽
    _layer.strokeEnd= _processValue;

    self.layer.cornerRadius=  height/2;

}

@end
