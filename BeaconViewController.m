//
//  BeaconViewController.m
//  LokasyonBeacon
//
//  Created by Emre YILMAZ on 04/05/2017.
//  Copyright © 2017 Emre YILMAZ. All rights reserved.
//

#import "BeaconViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface BeaconViewController ()<CLLocationManagerDelegate>


//Calculating
@property (nonatomic, strong)   NSMutableDictionary*        beaconDictionary;
@property(nonatomic)            NSMutableDictionary*        radiusDict;

//Moving Image (Map)
@property(nonatomic)            UIImage*                    ballImage;
@property(nonatomic)            UIImageView*                ball;
@property(nonatomic, assign)    CGPoint                     position;
@property (strong, nonatomic) CLLocationManager *locationManager;



@property (nonatomic) float BeaconDistanceOne;
@property (nonatomic) float BeaconDistanceTwo;
@property (nonatomic) float BeaconDistanceThree;


//BeaconID = 9576-49222
@property (nonatomic) float beaconOneCoordinateX;
@property (nonatomic) float beaconOneCoordinateY;

//BeaconID = 42634-3111
@property (nonatomic) float beaconTwoCoordinateX  ;
@property (nonatomic) float beaconTwoCoordinateY   ;

// BeaconID = 30219-54563
@property (nonatomic) float beaconThreeCoordinateX  ;
@property (nonatomic) float beaconThreeCoordinateY   ;

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _beaconOneCoordinateX = 0; _beaconOneCoordinateY = 0;
    
    _beaconTwoCoordinateX = 320; _beaconTwoCoordinateY = 0;
    
    _beaconThreeCoordinateX = 160; _beaconThreeCoordinateY = 480;
    
    // Do any additional setup after loading the view.
    
    //Animation (Test Ball)
    UIImage *ballImage = [UIImage imageNamed:@"pin"];
    self.ball = [[UIImageView alloc] initWithImage:ballImage];
    [self.view addSubview:self.ball];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //Beacon uuid belirlendi.
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                           identifier:@"SiyahBeacon"];
    //beacon tarama işlemi başlatıldı
    [self.locationManager startMonitoringForRegion:_beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:_beaconRegion];

}


#pragma mark - Location Manager
- (void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    //Gelen beaconlar Array'i indoorLocation Fonksiyonu içine gönderiliyor.
    //[self indoorLocation:beacons];
    
    for (CLBeacon *beacon in beacons) {
        if ([beacon.minor  isEqual: @10001]) {
            // NSLog(@"beaacon 1 :%.21g",beacon.accuracy);
            //NSLog(@"Normal metre: %.21Lg",beacon.accuracy * 5.956824406544L);
            //self.BeaconDistanceOne = beacon.accuracy * 5.956824406544L ;
           // self.BeaconDistanceOne = beacon.accuracy  ;
            self.BeaconDistanceOne = beacon.accuracy  ;
        }
        if ([beacon.minor  isEqual: @10002]) {
            // NSLog(@"beaacon 1 :%.21g",beacon.accuracy);
            //NSLog(@"Normal metre: %.21Lg",beacon.accuracy * 5.956824406544L);
          //  self.BeaconDistanceTwo = beacon.accuracy * 5.956824406544L ;
           // self.BeaconDistanceTwo = beacon.accuracy ;
            self.BeaconDistanceTwo = beacon.accuracy  ;
        }
        if ([beacon.minor  isEqual: @10003]) {
            // NSLog(@"beaacon 1 :%.21g",beacon.accuracy);
           // NSLog(@"Normal metre: %.21Lg",beacon.accuracy * 5.956824406544L);
           // self.BeaconDistanceThree = beacon.accuracy * 5.956824406544L ;
           // self.BeaconDistanceThree = beacon.accuracy ;
            self.BeaconDistanceThree = beacon.accuracy  ;
        }
    }


    //Calculating Distances with Factor (cm to Pixel)   *1 = Factor cm to Pixel
    _BeaconDistanceOne   = (_BeaconDistanceOne * 100)     *1;
    _BeaconDistanceTwo   = (_BeaconDistanceTwo * 100)     *1;
    _BeaconDistanceThree = (_BeaconDistanceThree * 100)   *1;
    
    
    //Calculating Delta Alpha Beta
    float Delta   = 4 * ((_beaconOneCoordinateX - _beaconTwoCoordinateX) * (_beaconOneCoordinateY - _beaconThreeCoordinateY) - (_beaconOneCoordinateX - _beaconThreeCoordinateX) * (_beaconOneCoordinateY - _beaconTwoCoordinateY));
    
    float Alpha   = (_BeaconDistanceTwo * _BeaconDistanceTwo) - (_BeaconDistanceOne * _BeaconDistanceOne) - (_beaconTwoCoordinateX * _beaconTwoCoordinateX) + (_beaconOneCoordinateX * _beaconOneCoordinateX) - (_beaconTwoCoordinateY * _beaconTwoCoordinateY) + (_beaconOneCoordinateY * _beaconOneCoordinateY);
  
    float Beta    = (_BeaconDistanceThree * _BeaconDistanceThree) - (_BeaconDistanceOne * _BeaconDistanceOne) - (_beaconThreeCoordinateX * _beaconThreeCoordinateX) + (_beaconOneCoordinateX * _beaconOneCoordinateX) - (_beaconThreeCoordinateY * _beaconThreeCoordinateY) + (_beaconOneCoordinateY * _beaconOneCoordinateY);

    //Real Calculating the Position (Triletaration
    float PositionX = (1/Delta) * (2 * Alpha * (_beaconOneCoordinateY - _beaconThreeCoordinateY) - 2 * Beta * (_beaconOneCoordinateY - _beaconTwoCoordinateY));
    float PositionY = (1/Delta) * (2 * Beta * (_beaconOneCoordinateX - _beaconTwoCoordinateX) - 2 * Alpha * (_beaconOneCoordinateX - _beaconThreeCoordinateX));


    
    NSLog(@"PositionX = %f", PositionX);
    NSLog(@"PositionX = %f", PositionY);
    
    NSLog(@"1.beacon = %f",self.BeaconDistanceOne);
    NSLog(@"2.beacon = %f",self.BeaconDistanceTwo);
    NSLog(@"3.beacon = %f",self.BeaconDistanceThree);


    NSString* PositionStringX = [NSString stringWithFormat:
                                 @"%f",
                                 PositionX];
    NSString* PositionStringY = [NSString stringWithFormat:
                                 @"%f",
                                 PositionY];

    self.position = CGPointMake(PositionX, PositionY);
    self.ball.center = self.position;



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
