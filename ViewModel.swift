//
//  ViewModel.swift
//  AirQualityApp
//
//  Created by Armagan Ercan on 2023-06-13.
//

import Foundation
import SwiftUI
import Combine
import MapKit
import CoreLocation

class AirViewModel: ObservableObject {
    
   
    @Published var airData:AirData?
   
    @Published var isLoading = false
    @Published var cityName = ""
    @ObservedObject var locationManager = LocationManager() 
    

    
    func fetchAirLocationData(latitude: Double, longitude: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(latitude)&lon=\(longitude)&appid=5f1b079f517658948c3770fbd6b61f43"
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                guard let data = data, error == nil else {
                    print("Failed to fetch air data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(AirResponse.self, from: data)
                    self?.airData = response.list.first
                } catch {
                    print("Failed to decode air data: \(error)")
                }
            }
        }.resume()
    }
    func fetchAirData() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(locationManager.location.coordinate.latitude)&lon=\(locationManager.location.coordinate.longitude)&appid=5f1b079f517658948c3770fbd6b61f43") else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch air data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let response = try decoder.decode(AirResponse.self, from: data)
                if let airData = response.list.first {
                    DispatchQueue.main.async {
                        self?.airData = airData
                    }
                }
            } catch {
                print("Failed to decode air data: \(error.localizedDescription)")
            }
        }.resume()
    }
    func reverseGeocode() {
        let location = CLLocation(latitude:locationManager.location.coordinate.latitude, longitude: locationManager.location.coordinate.longitude)
           let geocoder = CLGeocoder()

           geocoder.reverseGeocodeLocation(location) { placemarks, error in
               guard let placemark = placemarks?.first, error == nil else {
                   print("Reverse geocoding failed: \(error?.localizedDescription ?? "")")
                   return
               }

               if let city = placemark.locality {
                   self.cityName = city
               } else {
                   self.cityName = "Unknown"
               }
           }
       }
    

        
        
        
        
        
        
    }
    
    



