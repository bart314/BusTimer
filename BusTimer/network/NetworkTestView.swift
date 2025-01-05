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

#Preview {
    NetworkTestView(apiClient: APIClient())
}
