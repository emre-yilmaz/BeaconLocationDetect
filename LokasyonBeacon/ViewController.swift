//
//  ViewController.swift
//  LokasyonBeacon
//
//  Created by Elmas Mac on 24/04/2017.
//  Copyright © 2017 Emre YILMAZ. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825")! as UUID, identifier: "SiyahBeacon")
    var listBeacons = [CLBeacon()]
    
    var beaconOneDis =  Double()
    var beaconTwoDis = Double()
    var beaconThreeDis = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location manager ayarları yapıldı.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = 5
        
        //lokasyon izinleri kontrol edildi- izin yoksa izin istendi
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        //location manager baslatildi
        locationManager.startRangingBeacons(in: region)
        locationManager.startMonitoring(for: region)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        for beacon in beacons {
            print(beacon)
            
            if (beacon.minor == 10001) {
                print("O benimmm")
                self.beaconOneDis = beacon.accuracy
                
            }
            if (beacon.minor == 10002){
                self.beaconTwoDis = beacon.accuracy
            }
            if (beacon.minor == 10003) {
                self.beaconThreeDis = beacon.accuracy
            }
        
        print(beaconThreeDis,beaconTwoDis,beaconOneDis,"SELAM")
        
        }
        
        
        //listBeacons.removeAll()
      //  listBeacons = beacons;
        
        // print(beacons)
       // indoorLocationScan()
        
    }

    //Beacon 1
    let beaconOneCoordinateX = 0 ;
    let beaconOneCoordinateY = 0 ;
    
    //Beacon 1
    let beaconTwoCoordinateX = 320 ;
    let beaconTwoCoordinateY = 0 ;
    
    
    //Beacon 1
    let beaconThreeCoordinateX = 160 ;
    let beaconThreeCoordinateY = 480 ;
    

//    
//    //Calculating Distances with Factor (cm to Pixel)   *1 = Factor cm to Pixel
//    BeaconDistanceOne   = (BeaconDistanceOne * 100)     *1;
//    BeaconDistanceTwo   = (BeaconDistanceTwo * 100)     *1;
//    BeaconDistanceThree = (BeaconDistanceThree * 100)   *1;
//    
//    
//    //Calculating Delta Alpha Beta
//    float Delta   = 4 * ((beaconOneCoordinateX - beaconTwoCoordinateX) * (beaconOneCoordinateY - beaconThreeCoordinateY) - (beaconOneCoordinateX - beaconThreeCoordinateX) * (beaconOneCoordinateY - beaconTwoCoordinateY));
//    float Alpha   = (BeaconDistanceTwo * BeaconDistanceTwo) - (BeaconDistanceOne * BeaconDistanceOne) - (beaconTwoCoordinateX * beaconTwoCoordinateX) + (beaconOneCoordinateX * beaconOneCoordinateX) - (beaconTwoCoordinateY * beaconTwoCoordinateY) + (beaconOneCoordinateY * beaconOneCoordinateY);
//    float Beta    = (BeaconDistanceThree * BeaconDistanceThree) - (BeaconDistanceOne * BeaconDistanceOne) - (beaconThreeCoordinateX * beaconThreeCoordinateX) + (beaconOneCoordinateX * beaconOneCoordinateX) - (beaconThreeCoordinateY * beaconThreeCoordinateY) + (beaconOneCoordinateY * beaconOneCoordinateY);
//    
//    
//    
//    //Real Calculating the Position (Triletaration
//    float PositionX = (1/Delta) * (2 * Alpha * (beaconOneCoordinateY - beaconThreeCoordinateY) - 2 * Beta * (beaconOneCoordinateY - beaconTwoCoordinateY));
//    float PositionY = (1/Delta) * (2 * Beta * (beaconOneCoordinateX - beaconTwoCoordinateX) - 2 * Alpha * (beaconOneCoordinateX - beaconThreeCoordinateX));
//    
//    
//    NSLog(@"PositionX = %f", PositionX);
//    NSLog(@"PositionX = %f", PositionY);
//    
//    NSString* PositionStringX = [NSString stringWithFormat:
//    @"%f",
//    PositionX];
//    NSString* PositionStringY = [NSString stringWithFormat:
//    @"%f",
//    PositionY];
//    
//    
//    self.beaconDistanceOne.text     = PositionStringX;
//    self.distanceLabel.text         = PositionStringY;
//    
//    
//    self.position = CGPointMake(PositionX, PositionY);
//    self.ball.center = self.position;
//    
//    

}

