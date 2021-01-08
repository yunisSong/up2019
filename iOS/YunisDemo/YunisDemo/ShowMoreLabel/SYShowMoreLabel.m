//
//  SYShowMoreLabel.m
//  YunisDemo
//
//  Created by Yunis on 2020/8/14.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "SYShowMoreLabel.h"
#import <CoreText/CoreText.h>

@implementation SYShowMoreLabel
- (void)setMinNumbers:(int)minNumbers
{
	_minNumbers = minNumbers;
	
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
	NSLog(@"22 %@ ",[self getLinesArrayOfLabelRows:0]);

}
- (void)didMoveToWindow
{
	NSLog(@"33 %@ ",[self getLinesArrayOfLabelRows:0]);

}
- (void)didMoveToSuperview
{
	NSLog(@"44 %@ ",[self getLinesArrayOfLabelRows:0]);

}
- (void)layoutSubviews
{
	[super layoutSubviews];
	NSLog(@"55 %@ ",[self getLinesArrayOfLabelRows:0]);
	NSArray *lines = [self getLinesArrayOfLabelRows:0];
	NSArray *lines1 = [self getLinesArrayOfLabelRows];

	if (self.minNumbers >= lines.count ) {
		return;
	}
	NSMutableString *tempString = [NSMutableString new];
	for (int i = 0; i < self.minNumbers; i++) {
		NSLog(@"lines == %@",lines[i]);
		NSLog(@"lines1 == %@",lines1[i]);

		[tempString appendString:lines[i]];
	}
	NSLog(@"tempString == %@",tempString);

}

// 获取 Label 每行内容 得到一个数组
- (NSArray *)getLinesArrayOfLabelRows:(CGFloat)labelWidth{
	NSString *text = [self text];
	UIFont  *font = [self font];
	CGRect   rect = [self frame];
	NSLog(@"rect %@",NSStringFromCGRect(rect));
	CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
	NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
	[attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
	CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,MAXFLOAT));
	CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
	
	NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
	NSMutableArray *linesArray = [[NSMutableArray alloc]init];
	
	for (id line in lines)
	{
	   CTLineRef lineRef = (__bridge CTLineRef )line;
	   CFRange lineRange = CTLineGetStringRange(lineRef);
	   NSRange range = NSMakeRange(lineRange.location, lineRange.length);
	   
	   NSString *lineString = [text substringWithRange:range];
	   [linesArray addObject:lineString];
	}
	return (NSArray *)linesArray;
}

// 获取 Label 每行内容 得到一个数组
- (NSArray *)getLinesArrayOfLabelRows
{
    CGFloat labelWidth = self.frame.size.width;
    
    NSString *text = [self text];
    UIFont *font = [self font];
    if (text == nil) {
        return nil;
    }
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:(NSString *)kCTFontAttributeName
                   value:(__bridge  id)myFont
                   range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,labelWidth,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

@end
