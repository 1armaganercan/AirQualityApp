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


