//
//  BeaconViewController.h
//  LokasyonBeacon
//
//  Created by Emre YILMAZ on 04/05/2017.
//  Copyright © 2017 Emre YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface BeaconViewController : UIViewController

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

- (CGPoint)getCoordinateWithBeaconA:(CGPoint)a beaconB:(CGPoint)b beaconC:(CGPoint)c distanceA:(CGFloat)dA distanceB:(CGFloat)dB distanceC:(CGFloat)dC; 

@property (weak, nonatomic) IBOutlet UILabel *lblXCord;
@property (weak, nonatomic) IBOutlet UILabel *lblYCord;


@end
