//
//  VenueTableCell.m
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/1/31.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//

#import "VenueTableCell.h"
#define kPadding 20
#define kButtonSizeWidth 44
#define kButtonSizeHeight 44
#define kLabelHeightMin 40
#define kCellWidth self.frame.size.width
@interface VenueTableCell()
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *addressLabel;
@property (nonatomic,weak) UILabel *distanceLabel;
@property (nonatomic,weak) UIView *header;
@end
@implementation VenueTableCell
#pragma mark - layout subviews
- (void)awakeFromNib{
    // set up name label, distance label and address label, show map button, call cafe button
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
    
    // add to view
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.showMapBtn];
    [self.contentView addSubview:self.callVenuesBtn];
    
    
    [self.showMapBtn setImage:[UIImage imageNamed:@"current_location"] forState:UIControlStateNormal];
    [self.callVenuesBtn setImage:[UIImage imageNamed:@"MyCardPackage_PhoneHL"] forState:UIControlStateNormal];
    
    [self.showMapBtn addTarget:self.buttonDelegate action:@selector(showMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.callVenuesBtn addTarget:self.buttonDelegate action:@selector(callVenue:) forControlEvents:UIControlEventTouchUpInside];
    // UIVIEW header mock uitable view separator, default separator sometimes failed to appear.
    UIView *header = [[UIView alloc]init];
    [header setBackgroundColor:[UIColor lightGrayColor]];
    [header setAlpha:0.5];
    [self.contentView addSubview:header];
    self.header = header;
    [self setupAllFonts];
}

// layout all labels accordin to the corresponding text
- (void)layoutSubviews{
    CGSize nameSize = [self getText:self.nameLabel.text withFontSize:15 withWidth:self.contentView.frame.size.width/2];
    CGFloat height = nameSize.height;
    if (height < kLabelHeightMin) {
        height = kLabelHeightMin;
    }
    // resize each label and button according to the text
    // label widith minus 100 is to avoid overlap button
    [self.nameLabel setFrame:CGRectMake(kPadding, 0, kCellWidth - 100 , height)];
    // widith 90 can fit "Within 88888m"
    [self.distanceLabel setFrame:CGRectMake(kPadding, height , 90, kPadding)];
    // label widith minus 100 is to avoid overlap button
    [self.addressLabel setFrame:CGRectMake(kPadding, height + 15, kCellWidth - 100, kLabelHeightMin)];
    
    [self.showMapBtn setFrame:CGRectMake(kCellWidth - kPadding - kButtonSizeWidth, 5, kButtonSizeWidth, kButtonSizeHeight)];
    [self.callVenuesBtn setFrame:CGRectMake(kCellWidth - kPadding - kButtonSizeWidth, 10 + kButtonSizeHeight, kButtonSizeWidth, kButtonSizeHeight)];
    // header frame
    [self.header setFrame:CGRectMake(kPadding, 0, kCellWidth - kPadding, 1)];

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
    // tag is used for identify which cell has been selected.
    [self.showMapBtn setTag:indexPath.row];
    [self.callVenuesBtn setTag:indexPath.row];
    
}




@end
