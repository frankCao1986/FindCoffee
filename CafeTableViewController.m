//
//  CafeTableViewController.m
//  FindCoffee
//
//  Created by YUXIANG CAO on 15/1/30.
//  Copyright (c) 2015年 YUXIANG CAO. All rights reserved.
//
/*
 1. 获取用户坐标
 2. 形成最新的url 得到数据
 */
#import "CafeTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Venues.h"
#import "VenueTableCell.h"
#import "MBProgressHUD.h"
@interface CafeTableViewController() <NSURLConnectionDataDelegate,NSURLConnectionDelegate, CLLocationManagerDelegate, VenueTableCellButtonDelegate>
{
    CLLocationManager *_locationManager;
}
@property (nonatomic,assign)    CLLocationCoordinate2D coordinate;
@property (nonatomic,weak) UIActivityIndicatorView *activityIndicator;
@end
@implementation CafeTableViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    _dataList = [NSMutableArray array];
    // set up CLlocationManager parameters
    if ([CLLocationManager locationServicesEnabled]) {
        
        _locationManager = [[CLLocationManager alloc]init];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [_locationManager setDistanceFilter:10];
        [_locationManager startUpdatingLocation];
    }
    
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }
    else{
        // set up activity indicator while loading data
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [activityIndicatorView setCenter: self.navigationController.view.center];
        [activityIndicatorView setHidesWhenStopped:YES];
        [self.tableView addSubview:activityIndicatorView];
        self.activityIndicator = activityIndicatorView;
        
        [activityIndicatorView startAnimating];
        // set up navition bar
    
    }
    [self setTitle:@"Cafe Nearby"];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor darkTextColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

#pragma mark - location manager delegate method
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
// http get method to get data
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL&v=20150130",_locationManager.location.coordinate.latitude,_locationManager.location.coordinate.longitude]];
    NSLog(@"%f, %f",_locationManager.location.coordinate.latitude,_locationManager.location.coordinate.longitude);
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:&error];
    
    /*
    http request if failed at first time, then try another five times.  if all failed, then ask usser to check internet connection
     */
    NSInteger kconnectionTry = 0;
    while (error != nil){
        data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:&error];
        kconnectionTry++;
        if (kconnectionTry == 10) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not load Data" message:@"Please check your Internet connection" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alertView show];
            [_locationManager stopUpdatingLocation];
            return ;
        }
    }
    // parse json
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error != NULL) {
        NSLog(@"%@",error);
        return;
    }
    // set up data list
    _dataList = [self setupDataListWithDict:dict];
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}
#pragma mark mark set up dataList
- (NSMutableArray *)setupDataListWithDict:(NSDictionary *)dict{
    NSArray *array =dict[@"response"][@"venues"];
    // clear datalist once the location is updated.
    if (self.dataList != NULL) {
        [self.dataList removeAllObjects];
    }
    NSMutableArray *dataListM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        Venues *v = [[Venues alloc]initWithDict:dict];
        [dataListM addObject:v];
    }
    // sort by distance, ascending order
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:@"self.distance" ascending:YES];
    return [NSMutableArray arrayWithArray:[dataListM sortedArrayUsingDescriptors:@[descriptor]]];
    
}
#pragma - mark tableView data source method number of row
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // set up cell content with datalist
    VenueTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cafeCell"];
    [cell setButtonDelegate:self];
    Venues *v = self.dataList[indexPath.row];
    [cell setupCellWith:v withIndexPath:indexPath];
    
    return cell;
}
#pragma mark - button delegate method implementation
- (void)showMap:(UIButton *)sender{
    // show  in map
    Venues *v = self.dataList[sender.tag];
    MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:v.venueCoordinate addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = v.name;
    [item openInMapsWithLaunchOptions:nil];
}
- (void)callVenue:(UIButton *)sender{
    Venues *v = self.dataList[sender.tag];
    if (v.phone != NULL) {
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",v.phone]];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebview];
    }
    else{
        // give user instruction when there is no phone number available
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Sorry, phone call is not available";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1.5];
    }
}
@end
