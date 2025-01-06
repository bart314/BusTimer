//
//  APIClient.swift
//  BusTimer
//
//  Created by Docent HG on 28/07/2024.
//
// zie ook https://blog.stackademic.com/how-to-fetch-data-from-a-rest-api-in-swift-and-swiftui-a-beginners-guide-1c884538ccda


import Foundation
import SwiftSoup

class APIClient: ObservableObject {
    var target:String = ""
    
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
    
    
    func fetchDataBetter(completion: @escaping ([String]?) -> Void) {
        let url = self.target == "Groningen"
            ? "https://drgl.nl/stop/NL:S:10513410"
            : "https://drgl.nl/stop/NL:S:10006090"
        
        guard let url = URL(string: url) else {
            completion(nil)
            return;
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response or data")
                completion(nil)
                return
            }
            let tijden = self.parseRespons(String(data:data, encoding: .utf8)! )
            completion(tijden)
        }
        
        task.resume()
    }
    
    
    private func parseRespons(_ html:String) -> [String] {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let p: Elements = try doc.select("a.list-group-item")
            var rv:[String] = []
            for j in p {
                let line = try j.select("div.ott-linecode").text()
                if line == "6" {
                    let time = try j.select("div.ott-departure-time").text()
                    let dest = try j.select("div.ott-destination").text()
                    
                    if self.target == "Groningen" && dest == "Groningen" { rv.append(String(time)) }
                    else if self.target == "Garrelsweer" && dest == "Delfzijl" { rv.append(String(time)) }
                }
            }
            
            return rv
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return [""]
    }
    
    
}
