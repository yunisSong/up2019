//
//  NSDateTest.m
//  UP2019Tests
//
//  Created by Yunis on 2019/3/14.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+index.h"
@interface NSDateTest : XCTestCase

@end

@implementation NSDateTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testYesr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString == %@",currentTimeString);
    
    NSString *year = [currentTimeString substringToIndex:4];
    NSString *yearT = [NSDate year];
    XCTAssertEqual(year, yearT);
}

@end
