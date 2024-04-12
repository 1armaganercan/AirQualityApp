//
//  LocationManager.swift
//  AirQualityApp
//
//  Created by Armagan Ercan on 2023-06-13.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

class LocationManager : NSObject, CLLocationManagerDelegate, ObservableObject{
    
    var manager = CLLocationManager()
    @Published var location = CLLocation()
    var cityName = ""
    @Published var region = MKCoordinateRegion()
    
    override init(){
        
        super.init()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.delegate = self
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[locations.count - 1]
    }
   
   
  
    
    
    
}
