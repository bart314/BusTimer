//
//  APIClient.swift
//  BusTimer
//
//  Created by Docent HG on 28/07/2024.
//

import Foundation

class APIClient: ObservableObject {
    func fetchData() async throws -> [BusTijdResponse] {
        guard let url = URL(string: "http://localhost:8000/") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode([BusTijdResponse].self, from: data)
    }
}
