//
//  Venues.h
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/1/31.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface Venues : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger distance;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) CLLocationCoordinate2D venueCoordinate;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
