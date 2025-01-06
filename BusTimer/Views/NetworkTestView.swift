//
//  TestView.swift
//  BusTimer
//
//  Created by Docent HG on 28/07/2024.
//

import SwiftUI

struct NetworkTestView: View {
    @State var groningen:[String] = [""]
    @State var garrelsweer:[String] = [""]
    @State var isLoading:Bool = false
    
    let apiClient: APIClient
    
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
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
    NetworkTestView(apiClient: APIClient() )
}
