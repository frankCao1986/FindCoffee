//
//  VenueTableCell.h
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/1/31.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Venues.h"

@class VenueTableCell;
#pragma mark - button delegate
@protocol VenueTableCellButtonDelegate <NSObject>
#pragma mark show location
- (void)showMap:(UIButton *)sender;
#pragma mark call venues
- (void)callVenue:(UIButton *)sender;
@end


@interface VenueTableCell : UITableViewCell
@property (nonatomic,weak) id<VenueTableCellButtonDelegate> buttonDelegate;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,weak) UIButton *showMapBtn;
@property (nonatomic,weak) UIButton *callVenuesBtn;
- (void)setupCellWith:(Venues *)venue withIndexPath:(NSIndexPath *)indexPath;

@end
