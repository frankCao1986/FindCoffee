//
//  VenueTableCell.m
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/1/31.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//

#import "VenueTableCell.h"
@interface VenueTableCell()
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *addressLabel;
@property (nonatomic,weak) UILabel *distanceLabel;


@end
@implementation VenueTableCell
#pragma mark - layout subviews
- (void)awakeFromNib{

    UILabel *nameLabel = [[UILabel alloc]init];
    UILabel *distanceLabel = [[UILabel alloc]init];
    UILabel *addressLabel = [[UILabel alloc]init];
    UIButton *showMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *callVenuesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showMapBtn = showMapBtn;
    self.callVenuesBtn = callVenuesBtn;
    self.nameLabel = nameLabel;
    self.distanceLabel = distanceLabel;
    self.addressLabel = addressLabel;
    
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.showMapBtn];
    [self.contentView addSubview:self.callVenuesBtn];

    [self.contentView setBackgroundColor:[UIColor whiteColor]];


    [self.showMapBtn setImage:[UIImage imageNamed:@"current_location"] forState:UIControlStateNormal];

    [self.showMapBtn setBackgroundColor:[UIColor clearColor]];


    [self.callVenuesBtn setImage:[UIImage imageNamed:@"MyCardPackage_PhoneHL"] forState:UIControlStateNormal];
    
    [self.showMapBtn setTag:self.tag];
    [self.showMapBtn addTarget:self.buttonDelegate action:@selector(showMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.callVenuesBtn addTarget:self.buttonDelegate action:@selector(callVenue:) forControlEvents:UIControlEventTouchUpInside];
    [self setupAllFonts];
}
- (void)drawRect:(CGRect)rect{
    CGSize nameSize = [self getText:self.nameLabel.text withFontSize:15 withWidth:self.contentView.frame.size.width/2];
    CGFloat height = nameSize.height;
    if (height < 40) {
        height = 40;
    }
    [self.nameLabel setFrame:CGRectMake(20, 0, self.contentView.frame.size.width - 100 , height)];
    [self.distanceLabel setFrame:CGRectMake(20, height , 80, 20)];
    [self.addressLabel setFrame:CGRectMake(20, height + 15, self.contentView.frame.size.width - 100, 40)];
    [self.showMapBtn setFrame:CGRectMake(self.frame.size.width - 20 - 44, 5, 44, 44)];
    [self.callVenuesBtn setFrame:CGRectMake(self.frame.size.width - 20 - 44, 10 + 44, 44, 44)];
    [self setNeedsDisplay];
}
// caluate size for fit text for given string, font size, and label wiidth
- (CGSize)getText:(NSString *)string withFontSize:(CGFloat)fontSize withWidth:(CGFloat)width{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return CGSizeMake(rect.size.width, rect.size.height);
}
- (void)setupAllFonts{
    [self.nameLabel setFont:[UIFont systemFontOfSize:15]];
    [self.distanceLabel setFont:[UIFont systemFontOfSize:12]];
    [self.addressLabel setTextColor:[UIColor lightGrayColor]];
    [self.addressLabel setFont:[UIFont systemFontOfSize:10]];
    [self.addressLabel setNumberOfLines:0];
    [self.addressLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.nameLabel setNumberOfLines:0];
    [self.nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
}
#pragma mark - set data for Cell
- (void)setupCellWith:(Venues *)venue withIndexPath:(NSIndexPath *)indexPath{
    [self.nameLabel setText:venue.name];
    [self.distanceLabel setText:[NSString stringWithFormat:@"Within %ldm",(long)venue.distance]];
    [self.addressLabel setText:venue.address];
    [self.showMapBtn setTag:indexPath.row];
    [self.callVenuesBtn setTag:indexPath.row];
    
}




@end
