//
//  View.swift
//  AirQualityApp
//
//  Created by Armagan Ercan on 2023-06-13.
//

import Foundation
import SwiftUI
import Combine
import MapKit
import CoreLocation
import CoreLocationUI


struct AirView:View{
    
    @ObservedObject private var viewModel = AirViewModel()
    @State var cityName = ""
    @State var userRegion = LocationManager()
    @State var tracking = MapUserTrackingMode.follow
    
    
    var body: some View {
        
        
           VStack {
                   
               Map(coordinateRegion: $userRegion.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking).frame(width:400, height:400,alignment: .bottom).clipShape(Circle())
               
                   .padding()
               
               if let airData = viewModel.airData {
                   //Text("AQI: \(airData.components.aqi)")
                   Text("City: \(viewModel.cityName)").bold().onAppear{
                       
                       viewModel.reverseGeocode()
                       
                   }.font(.headline)
                   .padding()
                   Text("CO: \(airData.components.co, specifier: "%.2f")")
                   Text("NO: \(airData.components.no, specifier: "%.2f")")
                   Text("NO2: \(airData.components.no2, specifier: "%.2f")")
                   Text("O3: \(airData.components.o3, specifier: "%.2f")")
                   Text("SO2: \(airData.components.so2, specifier: "%.2f")")
                   Text("PM2.5: \(airData.components.pm25, specifier: "%.2f")")
                   Text("PM10: \(airData.components.pm10, specifier: "%.2f")")
                   Text("NH3: \(airData.components.nh3, specifier: "%.2f")")
               } else {
                   Text("Loading air data...")
               }
           }
           .onAppear {
               viewModel.fetchAirData()
           }
       }

    
    
}
