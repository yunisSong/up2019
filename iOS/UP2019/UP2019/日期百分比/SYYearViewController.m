//
//  SYYearViewController.m
//  UP2019
//
//  Created by Yunis on 2019/3/12.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "SYYearViewController.h"
#import "NSDate+index.h"
#import "LineProcessView.h"

@interface SYYearViewController ()

@end

@implementation SYYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#dacfcb"];
    
//    self.view.backgroundColor = [UIColor whiteColor];


    NSLog(@"%@",[NSDate year]);
    NSLog(@"%@",[NSDate month]);
    NSLog(@"%@",[NSDate day]);
    
    NSLog(@"indexOfWeek %d",[NSDate indexOfWeek]);
    NSLog(@"indexOfMonth %d",[NSDate indexOfMonth]);
    NSLog(@"indexOfYear %d",[NSDate indexOfYear]);
    
    NSLog(@"percentOfWeek %f",[NSDate percentOfWeek]);
    NSLog(@"percentOfMonth %f",[NSDate percentOfMonth]);
    NSLog(@"percentOfYear %f",[NSDate percentOfYear]);
    
    NSLog(@"weekdayString %@",[NSDate weekdayString]);
    
    /*
     显示内容
    
     今天是XXXX年 XX月 XX 日
     当前是几月的第几周
     当前是XXX年的第几周
     今天距离周末还有几天
     今天是周五吗
     这周过去的百分比
     这月过去的百分比
     今年过去的百分比
     
     */
    
    float originY = 100;
    [self creatTipWithTitle:[NSString stringWithFormat:@"%@ 年已经过去 %.2f%%",[NSDate year],[NSDate percentOfYear]*100] originY:originY font:[UIFont fontWithName:@"PingFangSC-Medium" size:18] process:[NSDate percentOfYear]];
    originY += 80;
    [self creatTipWithTitle:[NSString stringWithFormat:@"%@ 月已经过去 %.2f%%",[NSDate month],[NSDate percentOfMonth]*100] originY:originY font:[UIFont fontWithName:@"PingFangSC-Regular" size:18] process:[NSDate percentOfMonth]];
    
    originY += 80;
    [self creatTipWithTitle:[NSString stringWithFormat:@"今天是周 %@ ，本周已经过去 %.2f%%",[NSDate weekdayString],[NSDate percentOfWeek]*100] originY:originY font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:18] process:[NSDate percentOfWeek]];

    
    
    NSArray *familyNames = [UIFont familyNames];
    
    for (NSString *familyName in familyNames) {
        printf("familyNames = %s\n",[familyName UTF8String]);
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        for (NSString *fontName in fontNames) {
            printf("\tfontName = %s\n",[fontName UTF8String]);
        }
    }


}

- (void)creatTipWithTitle:(NSString *)title originY:(float)y font:(UIFont *)font process:(float )process
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, CGRectGetWidth(self.view.frame) - 40, 40)];
    label.font = font;
    label.text = title;
    label.textColor = [UIColor colorWithHexString:@"#6b5a53"];//586e75  2aa198  b58900  268bd2
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];

    LineProcessView *p1 = [[LineProcessView alloc] initWithFrame:CGRectMake(20, y + 40, CGRectGetWidth(self.view.frame) - 40, 20)];
    p1.processValue = process;
    p1.fillColor = [UIColor colorWithHexString:@"#6b5a53"]; //#859900
    p1.defaultColor = [UIColor colorWithHexString:@"#a4897e"];//2aa198
    [self.view addSubview:p1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
