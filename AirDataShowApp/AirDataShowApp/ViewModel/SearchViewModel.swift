//
//  searchViewModel.swift
//  AirQualityApp
//
//  Created by Armagan Ercan on 2024-05-22.
//

import Foundation
import SwiftUI
import Combine
import MapKit
import CoreLocation

class SearchViewModel: ObservableObject {
    
    @Published var searchAirData:AirData?
    @Published var coordinateData:coordinatesData?
    
    
    @Published var isLoading = false
    @Published var cityName = ""
    @ObservedObject var locationManager = LocationManager()
    
    @Published var coordinates:[CityCoordinates] = []
    private var cancellables = Set<AnyCancellable>()
    

    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
  
 
    func fetchAirData() {
    
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(latitude)&lon=\(longitude)&appid=5f1b079f517658948c3770fbd6b61f43") else {
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
                        self?.searchAirData = airData
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

    func fetchCoordinates(by city:String) {
          guard let url = URL(string:  "http://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=1&appid=appid=5f1b079f517658948c3770fbd6b61f43") else { return }
          
        URLSession.shared.dataTaskPublisher(for: url)
              .map { $0.data }
              .decode(type: [CityCoordinates].self, decoder: JSONDecoder())
              .receive(on: DispatchQueue.main)
              .sink(receiveCompletion: { completion in
                  self.isLoading = false
                  switch completion {
                  case .failure(let error):
                      print("Error fetching coordinates: \(error)")
                  case .finished:
                      break
                  }
              }, receiveValue: { [weak self] coordinates in
                  if let firstCoordinate = coordinates.first {
                                    self?.latitude = firstCoordinate.lat
                                    self?.longitude = firstCoordinate.lon
                                    //self?.fetchAirData()  // Fetch air data after coordinates are fetched
                                }
              })
              .store(in: &cancellables)
      }
      }
        
        
    
   
        
        
        
        
        
    
    
    




