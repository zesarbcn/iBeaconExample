//
//  TrackVC.h
//  iBeaconExample
//
//  Created by Cesar Perez Laguna on 07/09/14.
//  Copyright (c) 2014 Cesar Perez Laguna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TrackVC : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *beaconFoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityUUIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
