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


struct AirView: View {
    @StateObject var viewModel = AirViewModel()  // Ensures ViewModel is initialized only once here
    @State var locationManager = LocationManager()  // You should use @StateObject for managers too
    @State var tracking = MapUserTrackingMode.follow
    @State private var isPresented = false
    
    
    var body: some View {
        VStack{
            VStack{
                Map(coordinateRegion: Binding(get: {
                    // Ensure the region values are valid
                    var region = locationManager.region
                    if region.center.latitude.isNaN || region.center.longitude.isNaN {
                        // Provide a default region if NaN is detected
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }
                    return region
                }, set: { newRegion in
                    locationManager.region = newRegion
                }), interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking)
                
                if let airData = viewModel.airData {
                    Text("City: \(viewModel.cityName)").bold().onAppear{
                                            
                                            viewModel.reverseGeocode()
                                            
                                        }.font(.headline)
                  
                    VStack {
                        //Text("My City: \(viewModel.cityName)").bold().font(.headline).padding()
                        Text("CO: \(airData.components.co, specifier: "%.2f")ppm")
                        Text("NO: \(airData.components.no, specifier: "%.2f") ppb")
                        Text("NO2: \(airData.components.no2, specifier: "%.2f") ppb")
                        Text("O3: \(airData.components.o3, specifier: "%.2f") ppb")
                        Text("SO2: \(airData.components.so2, specifier: "%.2f") ppb")
                        Text("PM2.5: \(airData.components.pm25, specifier: "%.2f") µg/m3")
                        Text("PM10: \(airData.components.pm10, specifier: "%.2f") µg/m3")
                        Text("NH3: \(airData.components.nh3, specifier: "%.2f") ppb")
                    }
                } else {
                    Text("Loading air data...")
                }
            }.onAppear{

                viewModel.fetchAirData()
            
            }
            .padding()

            Button(action: {
                isPresented = true
            }) {
                NavigationLink(destination: SearchView()) {
                    Label("", systemImage: "eye").scaleEffect(1.5)
                                       }
            }
            
        }
  
        .padding()
    }
}
