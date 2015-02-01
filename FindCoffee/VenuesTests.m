//
//  VenuesTests.m
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/2/1.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>
#import "Venues.h"

@interface VenuesTests : XCTestCase
@property (nonatomic,strong) NSDictionary *dict;
@end

@implementation VenuesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    self.dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testName{
    Venues *v = [[Venues alloc]init];
    [v setName:@"Frank"];
    XCTAssert([v.name isEqualToString:@"Frank"],"name should be Frank");
    [v setName:nil];
    XCTAssertNil(v.name);
}
- (void)testDistance{
    Venues *v = [[Venues alloc]init];
    v.distance = 100;
    XCTAssertEqual(v.distance, 100);
    v.distance = 0;
    XCTAssertEqual(v.distance, 0);
    v.distance = -1;
    XCTAssertEqual(v.distance, 0);
    v.distance = -1000;
    XCTAssertEqual(v.distance, 0);
}

- (void)testAddress{
    Venues *v = [[Venues alloc]init];
    v.address = @"111/11-17 Woodville St, Hurstville, 2220, NSW";
    XCTAssert([v.address isEqualToString:@"111/11-17 Woodville St, Hurstville, 2220, NSW"], "address is 111/11-17 Woodville St, Hurstville, 2220, NSW");
}
- (void)testPhone{
    Venues *v = [[Venues alloc]init];
    v.phone = @"0425298061";
    XCTAssert([v.phone isEqualToString:@"0425298061"],@"phone number is 0425298061");
    
    v.phone =@"a042529852";
    v.phone = [v.phone stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    XCTAssertNil(v.phone, "phone num should be nil");
    v.phone =@"04252aa890";
    v.phone = [v.phone stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    XCTAssertNil(v.phone,"phone num should be nil");
    v.phone = @"0424248a";
    v.phone = [v.phone stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    XCTAssertNil(v.phone,"phone num should be nil");
    
}
- (void)testVenueCoordinate{
    Venues *v = [[Venues alloc]init];
    // test latitude normal and margin value
    v.venueCoordinate = CLLocationCoordinate2DMake(-50.000000,50.000000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 50.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(50.000000,50.000000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 50.000000 <= 0.0000001);
    // left margin test
    v.venueCoordinate = CLLocationCoordinate2DMake(-90.000000, 50.00000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 90.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(-90.000001, 50.00000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 0.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(-190.000001, 50.00000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 0.000000 <= 0.0000001);
    
    // right margin test
    v.venueCoordinate = CLLocationCoordinate2DMake(90.0000000, 50.00000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 90.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(90.000001, 50.00000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 0.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(190.000001, 50.00000);
    XCTAssert(fabs(v.venueCoordinate.latitude) - 0.000000 <= 0.0000001);
    
    
    // test longitude normal and margin value
    v.venueCoordinate = CLLocationCoordinate2DMake(-50.000000,-50.000000);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 50.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(50.000000,50.000000);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 50.000000 <= 0.0000001);
    // left marigin
    v.venueCoordinate = CLLocationCoordinate2DMake(-50.000000, -180.000000);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 180.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(-50.000001, -180.000001);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 0.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(-50.000001, -280.000000);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 0.000000 <= 0.0000001);
    //right margin
    v.venueCoordinate = CLLocationCoordinate2DMake(50.000000, 180.000000);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 180.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(50.000001, 180.000001);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 0.000000 <= 0.0000001);
    v.venueCoordinate = CLLocationCoordinate2DMake(50.000001, 280.000001);
    XCTAssert(fabs(v.venueCoordinate.longitude) - 0.000000 <= 0.0000001);

}
- (void)testMethodInitWithDict {
    // This is an example of a functional test case.
    NSArray *array =self.dict[@"response"][@"venues"];
    for (NSDictionary *item in array) {
        Venues *v = [[Venues alloc]initWithDict:item];
        XCTAssertEqual(v.name, item[@"name"]);
        XCTAssertEqual(v.distance, [item[@"location"][@"distance"] integerValue]);
        NSString *address = [[item[@"location"][@"formattedAddress"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
        XCTAssert([v.address isEqualToString:address],"pass");
        XCTAssertEqual(v.phone, item[@"contact"][@"phone"]);
        XCTAssertEqual(v.venueCoordinate.latitude, [item[@"location"][@"lat"] floatValue]);
        XCTAssertEqual(v.venueCoordinate.longitude, [item[@"location"][@"lng"] floatValue]);
    }
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
