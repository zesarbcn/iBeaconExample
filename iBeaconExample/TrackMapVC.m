//
//  TrackMapVC.m
//  iBeaconExample
//
//  Created by Cesar Perez Laguna on 10/09/14.
//  Copyright (c) 2014 Cesar Perez Laguna. All rights reserved.
//

#import "TrackMapVC.h"

#define MAX_DISTANCE 20
#define TOP_MARGIN   150

@interface TrackMapVC ()

@property (strong, nonatomic) CLBeacon          *beacon;
@property (strong, nonatomic) CLLocationManager *beaconManager;
@property (strong, nonatomic) CLBeaconRegion    *beaconRegion;

@property (nonatomic, strong) UIImageView       *backgroundImage;
@property (nonatomic, strong) UIImageView       *positionDot;
@property (nonatomic, strong) UIView            *infoDot;
@property (nonatomic, strong) UILabel           *messageLabel;

@end

@implementation TrackMapVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     * UI setup.
     */
    
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"distance_bkg"]];
    self.backgroundImage.frame = [UIScreen mainScreen].bounds;
    self.backgroundImage.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.backgroundImage];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *beaconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beacon"]];
    [beaconImageView setCenter:CGPointMake(self.view.center.x, 100)];
    [self.view addSubview:beaconImageView];
    
    self.positionDot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black_dot"]];
    [self.positionDot setCenter:self.view.center];
    [self.view addSubview:self.positionDot];
    
    // Show a custom view as toast
    self.infoDot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)/2.5, 50)];
    [self.infoDot setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)]; // autoresizing masks are respected on custom views
    [self.infoDot setBackgroundColor:[UIColor orangeColor]];
    self.infoDot.layer.cornerRadius = 5.0;
    self.infoDot.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.infoDot setCenter:CGPointMake(-100, -100)];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.frame = CGRectMake(10.0, 0.0, CGRectGetWidth(self.view.frame)/2.5, 50);
    self.messageLabel.textColor = [UIColor whiteColor];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    //self.messageLabel.text = [NSString stringWithFormat:@"accuracy %d", (int)self.beacon.accuracy];
    [self.infoDot addSubview:self.messageLabel];
    [self.view addSubview:self.infoDot];
    
    /*
     * BeaconManager setup.
     */
    self.beaconManager = [[CLLocationManager alloc] init];
    self.beaconManager.delegate = self;
    [self initRegion];
    
    // Start monitoring (to FIX)
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
    
    [super viewDidDisappear:animated];
}

- (void)initRegion {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"2146A901-B2C0-4440-8088-4B3E6F9F42D8"];
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                           identifier:@"com.zesarbcn.myRegion"];
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager
       didRangeBeacons:(NSArray *)beacons
              inRegion:(CLBeaconRegion *)region {
    
    
    self.beacon = [beacons firstObject];
    
    [self updateDotPositionForDistance:self.beacon.accuracy];
}

- (void)updateDotPositionForDistance:(double)distance
{
    NSLog(@"distance: %f", distance);
    
    float step = (self.view.frame.size.height - TOP_MARGIN) / MAX_DISTANCE;
    
    int newY = TOP_MARGIN + (distance * step);
    
    
    self.messageLabel.text = [NSString stringWithFormat:@"accuracy %.02f", (float)distance];
    
    [self.infoDot setCenter:CGPointMake(self.view.center.x + 8 + CGRectGetWidth(self.infoDot.frame)/2,
                                        newY + 8 + CGRectGetHeight(self.infoDot.frame)/2)];
    
    [self.positionDot setCenter:CGPointMake(self.positionDot.center.x, newY)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
