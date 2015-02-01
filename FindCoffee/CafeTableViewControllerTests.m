//
//  CafeTableViewControllerTests.m
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/2/1.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "CafeTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Venues.h"
@interface CafeTableViewControllerTests : XCTestCase
@property (nonatomic,strong) CafeTableViewController *controller;
@property (nonatomic,strong) NSDictionary *dict;
@end
@interface CafeTableViewController(Testing)
- (NSMutableArray *)setupDataListWithDict:(NSDictionary *)dict;
@end
@implementation CafeTableViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.controller = [[CafeTableViewController alloc]init];
    [self.controller viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    self.dict = [NSDictionary dictionaryWithContentsOfFile:path];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testSetupMethod{
    NSMutableArray *arrayM = [self.controller setupDataListWithDict:self.dict];
    for(NSInteger i = 1 ; i < arrayM.count; i++){
        Venues *v1 = arrayM[i-1];
        Venues *v2 = arrayM[i];
        XCTAssertGreaterThanOrEqual(v2.distance, v1.distance);
    }
}
- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
