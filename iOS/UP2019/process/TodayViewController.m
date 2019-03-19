//
//  TodayViewController.m
//  process
//
//  Created by Yunis on 2019/3/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "NSDate+index.h"
#import "LineProcessView.h"
#import "UIColor+Extension.h"
@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadSubViews];//preferredContentSize
    
//    self.preferredContentSize = CGSizeMake(400, 200);
//    NSLog(@"1111");
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
        
    }
    

}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        self.preferredContentSize = CGSizeMake(maxSize.width, 85);
        
    } else if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        CGFloat height = 1 + 60*5 + 30*4;
        self.preferredContentSize = CGSizeMake(maxSize.width,height );
        
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    NSLog(@"222222");

    completionHandler(NCUpdateResultNewData);
}


- (void)loadSubViews {
    float originY = 15;
    
     NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
    formatter.locale = locale;
    NSString *weekZHString = [formatter stringFromNumber:[NSNumber numberWithInt: [[NSDate weekdayString] intValue]]];

    [self creatTipWithTitle:[NSString stringWithFormat:@"%@年%@月%@日周%@",[NSDate year],[NSDate month],[NSDate day],weekZHString] font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:24] originY:originY];
    originY += 30;
    
    NSString *str = @"";
    if ([NSDate indexOfWeek] == 5) {
        str = @"今天是周五😁";
        [self creatTipWithTitle:str font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:26] originY:originY color:[UIColor colorWithHexString:@"#ff420e"]];

    }else if ([NSDate indexOfWeek] == 6 || [NSDate indexOfWeek] == 7)
    {
        str = @"今天是周末😁";
        [self creatTipWithTitle:str font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:26] originY:originY color:[UIColor colorWithHexString:@"#ff420e"]];
    }else
    {
        str = @"今天不是周五😂";
        [self creatTipWithTitle:str font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:20] originY:originY];
    }
    
    originY += 60;
    
    [self creatTipWithTitle:[NSString stringWithFormat:@"%@已经过去了%d天",[NSDate year],[NSDate indexOfYear]] font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:20] originY:originY];
    originY += 30;
    [self creatTipWithTitle:[NSString stringWithFormat:@"余下 %d 天请多努力！",[NSDate lastOfYear]] font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:22] originY:originY];
    originY += 50;
    
    
//    NSString *yearZHString = [formatter stringFromNumber:[NSNumber numberWithInt: [[NSDate year] intValue]]];

    [self creatTipWithTitle:[NSString stringWithFormat:@"%@ 年已经过去 %.2f%%",[NSDate year] ,[NSDate percentOfYear]*100] font:nil originY:originY];
    originY += 45;
    [self creatWithProcess:[NSDate percentOfYear] originY:originY];
    originY += 30;
    
    
    NSString *monthZHString = [formatter stringFromNumber:[NSNumber numberWithInt: [[NSDate month] intValue]]];

    [self creatTipWithTitle:[NSString stringWithFormat:@"%@月已经过去 %.2f%%",monthZHString,[NSDate percentOfMonth]*100] font:nil originY:originY];
    originY += 45;
    [self creatWithProcess:[NSDate percentOfMonth] originY:originY];
    originY += 30;
    
    
    [self creatTipWithTitle:[NSString stringWithFormat:@"今天是周%@ ，本周已经过去 %.2f%%",weekZHString,[NSDate percentOfWeek]*100] font:nil originY:originY];
    originY += 45;
    [self creatWithProcess:[NSDate percentOfWeek] originY:originY];
    originY += 30;
    
}

- (void)creatTipWithTitle:(NSString *)title font:(UIFont *)font originY:(float)y
{
    if (!font) {
        font = [UIFont fontWithName:@"MyanmarSangamMN-Bold" size:18];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, CGRectGetWidth(self.view.frame) - 40, 60)];
    label.font = font;
    label.text = title;
    label.textColor = [UIColor colorWithHexString:@"#6b5a53"];//586e75  2aa198  b58900  268bd2
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
}

- (void)creatTipWithTitle:(NSString *)title font:(UIFont *)font originY:(float)y color:(UIColor *)color
{
    if (!font) {
//        font = [UIFont fontWithName:@"MyanmarSangamMN-Bold" size:18];
        font = [UIFont systemFontOfSize:18.f];

    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, CGRectGetWidth(self.view.frame) - 40, 60)];
    label.font = font;
    label.text = title;
    label.textColor = color;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
}

- (void)creatWithProcess:(float )process originY:(float)y
{
    LineProcessView *p1 = [[LineProcessView alloc] initWithFrame:CGRectMake(20, y , CGRectGetWidth(self.view.frame) - 50, 20)];
    p1.processValue = process;
    p1.fillColor = [UIColor colorWithHexString:@"#6b5a53"]; //#859900
    p1.defaultColor = [UIColor colorWithHexString:@"#a4897e"];//2aa198
    [self.view addSubview:p1];
}

@end
