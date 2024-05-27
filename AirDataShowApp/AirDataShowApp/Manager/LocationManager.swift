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

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    //@Published var location = CLLocation()
    @Published var locationUpdated: Bool = false
    @Published var region = MKCoordinateRegion()
    @Published var location = CLLocation()
    var cityName = ""
    
  
    
   

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
   

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        //location = locations[locations.count - 1]
        
        guard let newLocation = locations.first else{return }
              DispatchQueue.main.async {
                  self.location = newLocation  // Update published location
                  self.locationUpdated = true  // Notify subscribers that location is updated
              }
          }
    func startUpdatingLocation() {
            locationManager.requestWhenInUseAuthorization() // Request permission
            locationManager.startUpdatingLocation() // Start location updates
        }
        

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                // Continue trying or implement retry logic
                print("Location is currently unknown; retrying...")
            case .denied:
                // Location services are denied. Alert the user.
                print("Location services are denied. Please enable them in settings.")
            default:
                print("Other CLLocation error occurred: \(clError.localizedDescription)")
            }
        }
    }
    func promptForLocationService() {
        let alertController = UIAlertController(title: "Location Access Disabled",
                                                message: "In order to be useful, please open this app's settings and set location access to 'While Using the App'.",
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(openAction)

    }
    
 

    

}
   
