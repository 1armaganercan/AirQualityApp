//
//  ContentView.swift
//  AirQualityApp
//
//  Created by Armagan Ercan on 2023-06-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
           NavigationView {
               AirView()
              
                   
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
