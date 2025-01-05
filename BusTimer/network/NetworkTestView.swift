//
//  TestView.swift
//  BusTimer
//
//  Created by Docent HG on 28/07/2024.
//

import SwiftUI

struct NetworkTestView: View {
    @State private var apiResponse: [BusTijdResponse] = []
    @State private var errorMessage: String?
    
    let apiClient: APIClient

    var body: some View {
        VStack {
            if !apiResponse.isEmpty {
                List(apiResponse, id: \.halte) { item in
                    VStack(alignment: .leading) {
                        let foo:TimeInterval = item.tijden[0]
                        Text("Halte: \(item.halte)")
                        Text("Tijden: \(item.tijden)")
                    }
                }
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Loading...")
            }
        }
        .task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        do {
            apiResponse = try await apiClient.fetchData()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


struct NewNetworkTestView: View {
    @State var groningen:[String] = ["Henk", "Karel"]
    @State var garrelsweer:[String] = ["Pieter", "Chantal"]
    @State var isLoading:Bool = false
    
    let apiClient: APIClient
    
    var body: some View {
        VStack {
            Button("Naar Groningen") {
                isLoading = true
                self.getData("Groningen")
            }
            NavigationView {
                List(groningen, id: \.self) { el in
                    Text(el)
                }
            }.overlay(isLoading ? ProgressView() : nil)
            Spacer()
            Button("Naar Garrelsweer") {
                isLoading = true
                self.getData("Garrelsweer")
            }
            NavigationView {
                List(garrelsweer, id: \.self) { el in
                    Text(el)
                }
            }.overlay(isLoading ? ProgressView() : nil)
        }
    }
    
    private func getData(_ waar:String) {
        self.apiClient.target = waar
        
        self.apiClient.fetchDataBetter { tijden in
            DispatchQueue.main.async {
                if waar == "Groningen" {
                    self.groningen = tijden ?? [""]
                } else {
                    self.garrelsweer = tijden ?? [""]
                }
                self.isLoading = false
            }
        }
    }
}

#Preview {
    NewNetworkTestView(apiClient: APIClient() )
}
