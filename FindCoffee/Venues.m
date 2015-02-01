//
//  Venues.m
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/1/31.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//

#import "Venues.h"

@implementation Venues
#pragma mark - init method
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self != NULL) {
        self.name = dict[@"name"];
        NSNumber *integer = dict[@"location"][@"distance"];
        self.address = [[dict[@"location"][@"formattedAddress"] valueForKey:@"description"] componentsJoinedByString:@"\n"];
        self.distance = [integer integerValue];
        self.phone = dict[@"contact"][@"phone"];
        self.venueCoordinate  = CLLocationCoordinate2DMake([dict[@"location"][@"lat"] floatValue], [dict[@"location"][@"lng"] floatValue]);
    }
    return self;
}
#pragma mark - setter method
#pragma mark distance method
- (void)setDistance:(NSInteger)distance{
    _distance = distance;
    if (0 >= _distance) {
        _distance = 0;
    }
}
#pragma mark phone number method
- (void)setPhone:(NSString *)phone{
    _phone = phone;
    NSString *str = [_phone stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (str.length != 0) {
        _phone = nil;
    }
}
#pragma mark VenueCoordinate method
- (void)setVenueCoordinate:(CLLocationCoordinate2D)venueCoordinate{
    _venueCoordinate = venueCoordinate;
    if(fabs(_venueCoordinate.latitude) - 90.000000 >= 0.0000001){
        _venueCoordinate.latitude = 0.0000000;
    }
    if(fabs(_venueCoordinate.longitude) - 180.0000000 >= 0.0000001){
        _venueCoordinate.longitude = 0.0000000;
    }
}
@end
