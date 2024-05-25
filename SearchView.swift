import SwiftUI

struct SearchView: View {
    @StateObject var searchviewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack{
                TextField("Enter city name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Search") {
                    performSearch()
                }
                if let airData = searchviewModel.searchAirData {
                    Text("City: \(searchText)").bold().onAppear{
                                            
                                            searchviewModel.fetchCoordinates(by: searchText)
                                            
                                        }.font(.headline)
                  
                    VStack {
                    
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
            }
            
            
            
            
            
                   /* VStack {
                        TextField("Enter city name", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        Button("Search") {
                            performSearch()
                        }
                            
                          
                                if let airData = viewModel.searchAirData, !searchText.isEmpty {
                                    
                                    Text("Air Quality in \(viewModel.cityName)").bold().font(.headline).padding()
                                    Text("CO: \(airData.components.co, specifier: "%.2f") ppm")
                                    Text("NO: \(airData.components.no, specifier: "%.2f") ppb")
                                    Text("NO2: \(airData.components.no2, specifier: "%.2f") ppb")
                                    Text("O3: \(airData.components.o3, specifier: "%.2f") ppb")
                                    Text("SO2: \(airData.components.so2, specifier: "%.2f") ppb")
                                    Text("PM2.5: \(airData.components.pm25, specifier: "%.2f") µg/m3")
                                    Text("PM10: \(airData.components.pm10, specifier: "%.2f") µg/m3")
                                    
                                    
                                } else {
                                    Text("Enter a city name and press search.")
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                            
                        
                    }
                    .navigationBarTitle("Search City", displayMode: .inline)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                           
                    } */
                }
            }

            func performSearch() {
                guard !searchText.isEmpty else {
                    alertMessage = "City name cannot be empty."
                    showingAlert = true
                    return
                }
                searchviewModel.fetchAirData()
                //searchviewModel.fetchCoordinates(by: searchText)
            }

    
    
    
        }
    
    






 

