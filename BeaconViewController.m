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

@property(nonatomic, assign)    CGPoint                     beacon1;
@property(nonatomic, assign)    CGPoint                     beacon2;
@property(nonatomic, assign)    CGPoint                     beacon3;

@property(nonatomic)            UIImage*                    beaconImage1;
@property(nonatomic)            UIImageView*                beaconView1;

@property(nonatomic)            UIImage*                    beaconImage2;
@property(nonatomic)            UIImageView*                beaconView2;

@property(nonatomic)            UIImage*                    beaconImage3;
@property(nonatomic)            UIImageView*                beaconView3;


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
@synthesize lblXCord,lblYCord;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _beaconOneCoordinateX = 0; _beaconOneCoordinateY = 0;
    
    _beaconTwoCoordinateX = 370; _beaconTwoCoordinateY = 50;
    
    _beaconThreeCoordinateX = 20; _beaconThreeCoordinateY = 400;
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    
//    self.beaconImage1 = [UIImage imageNamed:@"imgBeacon"];
//    self.beaconView1 = [[UIImageView alloc] initWithImage:self.beaconImage1];
//    self.beaconView1.frame = CGRectMake(self.beaconOneCoordinateX, self.beaconOneCoordinateY, 24, 24);
//    self.beaconView1.center = CGPointMake(self.beaconOneCoordinateX, self.beaconOneCoordinateY);
//    [self.view addSubview:self.beaconView1];
//    
//    self.beaconImage2 = [UIImage imageNamed:@"imgBeacon"];
//    self.beaconView2 = [[UIImageView alloc] initWithImage:self.beaconImage2];
//    self.beaconView2.frame = CGRectMake(self.beaconTwoCoordinateX, self.beaconTwoCoordinateY, 24, 24);
//    [self.view addSubview:self.beaconView2];
//    
//    self.beaconImage3 = [UIImage imageNamed:@"imgBeacon"];
//    self.beaconView3 = [[UIImageView alloc] initWithImage:self.beaconImage3];
//    self.beaconView3.frame = CGRectMake(self.beaconThreeCoordinateX, self.beaconThreeCoordinateY, 24, 24);
//    [self.view addSubview:self.beaconView3];
//    
//    self.beaconView2.center = CGPointMake(self.beaconTwoCoordinateX, self.beaconTwoCoordinateY);
//    self.beaconView3.center = CGPointMake(self.beaconThreeCoordinateX, self.beaconThreeCoordinateY);
//    
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
 //   _BeaconDistanceOne   = (_BeaconDistanceOne * 100)     *1;
 //   _BeaconDistanceTwo   = (_BeaconDistanceTwo * 100)     *1;
 //   _BeaconDistanceThree = (_BeaconDistanceThree * 100)   *1;
    
    
    //Calculating Delta Alpha Beta
    float Delta   = 4 * ((_beaconOneCoordinateX - _beaconTwoCoordinateX) * (_beaconOneCoordinateY - _beaconThreeCoordinateY) - (_beaconOneCoordinateX - _beaconThreeCoordinateX) * (_beaconOneCoordinateY - _beaconTwoCoordinateY));
    
    float Alpha   = (_BeaconDistanceTwo * _BeaconDistanceTwo) - (_BeaconDistanceOne * _BeaconDistanceOne) - (_beaconTwoCoordinateX * _beaconTwoCoordinateX) + (_beaconOneCoordinateX * _beaconOneCoordinateX) - (_beaconTwoCoordinateY * _beaconTwoCoordinateY) + (_beaconOneCoordinateY * _beaconOneCoordinateY);
  
    float Beta    = (_BeaconDistanceThree * _BeaconDistanceThree) - (_BeaconDistanceOne * _BeaconDistanceOne) - (_beaconThreeCoordinateX * _beaconThreeCoordinateX) + (_beaconOneCoordinateX * _beaconOneCoordinateX) - (_beaconThreeCoordinateY * _beaconThreeCoordinateY) + (_beaconOneCoordinateY * _beaconOneCoordinateY);

    //Real Calculating the Position (Triletaration
    float PositionX = (1/Delta) * (2 * Alpha * (_beaconOneCoordinateY - _beaconThreeCoordinateY) - 2 * Beta * (_beaconOneCoordinateY - _beaconTwoCoordinateY));
    float PositionY = (1/Delta) * (2 * Beta * (_beaconOneCoordinateX - _beaconTwoCoordinateX) - 2 * Alpha * (_beaconOneCoordinateX - _beaconThreeCoordinateX));


//    int xa = position1.x;
//    int ya = position1.y;
//    int xb = position2.x;
//    int yb = position2.y;
//    int xc = position3.x;
//    int yc = position3.y;
    
    float xa = _beaconOneCoordinateX;
    float ya = _beaconOneCoordinateY;
    float xb = _beaconTwoCoordinateX;
    float yb = _beaconTwoCoordinateY;
    float xc = _beaconThreeCoordinateX;
    float yc = _beaconThreeCoordinateY;
    double ra = _BeaconDistanceOne;
    double rb = _BeaconDistanceTwo;
    double rc = _BeaconDistanceThree;
//    
    
    
//    double S = (Math.pow(xc, 2.) - Math.pow(xb, 2.) + Math.pow(yc, 2.) - Math.pow(yb, 2.)// + Math.pow(rb, 2.) -// Math.pow(rc, 2.)) / 2.0;
//    double T = (Math.pow(xa, 2.) - Math.pow(xb, 2.) + Math.pow(ya, 2.) - Math.pow(yb, 2.) + Math.pow(rb, 2.) - Math.pow(ra, 2.)) / 2.0;
//    double y = ((T * (xb - xc)) - (S * (xb - xa))) / (((ya - yb) * (xb - xc)) - ((yc - yb) * (xb - xa)));
//    double x = ((y * (ya - yb)) - T) / (xb - xa);

    
//    float S = ((_beaconThreeCoordinateX * _beaconThreeCoordinateX )-(_beaconTwoCoordinateX * _beaconTwoCoordinateX)+
//    (_beaconThreeCoordinateY * _beaconThreeCoordinateY)-(_beaconTwoCoordinateY*_beaconTwoCoordinateY)+(_BeaconDistanceTwo*_BeaconDistanceTwo)-(_BeaconDistanceOne*_BeaconDistanceOne))/2;
//    
//    float T = ((_beaconOneCoordinateX*_beaconOneCoordinateX)-(_beaconTwoCoordinateX*_beaconTwoCoordinateX)+(_beaconOneCoordinateY*_beaconOneCoordinateY)-
//               (_beaconTwoCoordinateY*_beaconTwoCoordinateY)+(_BeaconDistanceTwo*_BeaconDistanceTwo)-(_BeaconDistanceOne*_BeaconDistanceOne))/2;
    
    
        double S = ((xc*xc) - (xb*xb) + (yc*yc) - (yb*yb) + (rb*rb) - (rc*rc)) / 2.0;
        double T = ((xa*xa) - (xb*xb) + (ya*ya) - (yb*yb) + (rb*rb) - (ra*ra)) / 2.0;
    
    float y = ((T * (xb - xc)) - (S * (xb - xa))) / (((ya - yb) * (xb - xc)) - ((yc - yb) * (xb - xa)));
    float x = ((y * (ya - yb)) - T) / (xb - xa);
    
   // NSLog(@"PositionX = %f", y);
   // NSLog(@"PositionY = %f", x);
 
  //  NSLog(@"PositionX = %f", PositionX);
   // NSLog(@"PositionY = %f", PositionY);
    
  //  NSLog(@"1.beacon = %f",self.BeaconDistanceOne);
  //  NSLog(@"2.beacon = %f",self.BeaconDistanceTwo);
  //  NSLog(@"3.beacon = %f",self.BeaconDistanceThree);


    NSString* PositionStringX = [NSString stringWithFormat:
                                 @"%f",
                                 PositionX];
    NSString* PositionStringY = [NSString stringWithFormat:
                                 @"%f",
                                 PositionY];

    self.position = CGPointMake(x, y);
    self.ball.center = self.position;
    self.position = [self getCoordinateWithBeaconA:CGPointMake(_beaconOneCoordinateX, _beaconOneCoordinateY) beaconB:CGPointMake(_beaconTwoCoordinateX, _beaconTwoCoordinateY) beaconC:CGPointMake(_beaconThreeCoordinateX, _beaconThreeCoordinateY) distanceA:_BeaconDistanceOne distanceB:_BeaconDistanceTwo distanceC:_BeaconDistanceThree];


}

- (CGPoint)getCoordinateWithBeaconA:(CGPoint)a beaconB:(CGPoint)b beaconC:(CGPoint)c distanceA:(CGFloat)dA distanceB:(CGFloat)dB distanceC:(CGFloat)dC {
    CGFloat W, Z, x, y, y2;
    W = dA*dA - dB*dB - a.x*a.x - a.y*a.y + b.x*b.x + b.y*b.y;
    Z = dB*dB - dC*dC - b.x*b.x - b.y*b.y + c.x*c.x + c.y*c.y;
    
    x = (W*(c.y-b.y) - Z*(b.y-a.y)) / (2 * ((b.x-a.x)*(c.y-b.y) - (c.x-b.x)*(b.y-a.y)));
    y = (W - 2*x*(b.x-a.x)) / (2*(b.y-a.y));
    //y2 is a second measure of y to mitigate errors
    y2 = (Z - 2*x*(c.x-b.x)) / (2*(c.y-b.y));
    
    y = (y + y2) / 2;
    
    NSLog(@"PositionX = %f", y);
    NSLog(@"PositionY = %f", x);
   
    
    NSString* PositionStringX = [NSString stringWithFormat:
                                 @"%f",
                                 x];
    NSString* PositionStringY = [NSString stringWithFormat:
                                 @"%f",
                                 y];
    lblYCord.text = PositionStringX ;
    lblXCord.text = PositionStringY ;
    
    return CGPointMake(x, y);
    
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
