//
//  BusTijdResponse.swift
//  BusTimer
//
//  Created by Docent HG on 28/07/2024.
//

import Foundation

struct BusTijdResponse:Codable{
    let halte:String
    let tijden:[TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case halte
        case tijden
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        halte = try container.decode(String.self, forKey: .halte)
        let timeStrings = try container.decode([String].self, forKey: .tijden)
        tijden = timeStrings.compactMap { timeString in
            return BusTijdResponse.timeInterval(from: timeString)
        }
    }
    
    static func timeInterval(from timeString:String) -> TimeInterval {
        let components = timeString.split(separator: ":")
        guard components.count == 2,
              let mins = Int(components[0]),
              let secs = Int(components[1])
        else {
            return 0
        }
        
        return TimeInterval(mins*60 + secs)
    }
}
    
    
    
    
