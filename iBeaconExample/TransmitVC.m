//
//  TransmitVC.m
//  iBeaconExample
//
//  Created by Cesar Perez Laguna on 07/09/14.
//  Copyright (c) 2014 Cesar Perez Laguna. All rights reserved.
//

#import "TransmitVC.h"

@interface TransmitVC ()

@end

@implementation TransmitVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initBeacon];
    [self setLabels];
}

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"2146A901-B2C0-4440-8088-4B3E6F9F42D8"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.zesarbcn.myRegion"];
}

- (void)setLabels {
    self.uuidLabel.text = self.beaconRegion.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.minor];
    self.identityLabel.text = self.beaconRegion.identifier;
}

- (IBAction)transmitBeacon:(UIButton *)sender {
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
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
