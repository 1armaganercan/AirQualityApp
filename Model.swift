//
//  Model.swift
//  AirQualityApp
//
//  Created by Armagan Ercan on 2023-06-13.
//

import Foundation
import Combine
import SwiftUI



struct AirResponse:Codable{
    
    let list:[AirData]
    
}

struct AirData:Codable{
    
    let components:parameters

}
struct parameters:Codable{
    
 
    let co:Double
    let no:Double
    let no2:Double
    let o3:Double
    let so2:Double
    let pm25:Double
    let pm10:Double
    let nh3:Double

}

struct coordinatesData:Codable{
    
    let coordinates:[CityCoordinates]
    
}

struct CityCoordinates: Codable {
 
    let lat: Double
    let lon: Double
}


/*struct CoordinateData: Codable {
    let name: String?
    let lat: Double
    let lon: Double
 

    var coordinates: CityCoordinates {
        CityCoordinates(lat: lat, lon: lon)
    }
}

struct CityCoordinates: Codable, Identifiable {
    var id: UUID = UUID()
    let lat: Double
    let lon: Double
}






struct CoordinateResponse:Codable{
    
    let coordinateList:[CoordinateData]
    
}



struct CoordinateData:Codable{
    
    let coordinates:CityCoordinates
    
}

struct CityCoordinates: Codable, Identifiable {
    var id: UUID = UUID()
    let lat: Double
    let lon: Double
}*/


