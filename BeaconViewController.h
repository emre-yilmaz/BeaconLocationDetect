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


@end
