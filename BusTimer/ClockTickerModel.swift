//
//  TickerModel.swift
//  BusTimer
//
//  Created by Docent HG on 23/07/2024.
//

import Foundation

struct ClockTickerModel {
    enum TickerType {
        case second
        case hour
        case minute
    }
    let type: TickerType
    let timeInterval: TimeInterval
    let tickScale: CGFloat
    
    var angleMultiplier: CGFloat {
        switch type {
        case .second:
            return CGFloat(self.timeInterval.remainder(dividingBy: 60)) / 60
        case .minute:
            return CGFloat((timeInterval - Double(Int(timeInterval / 3600) * 3600)) / 60) / 60
        case .hour:
            return CGFloat(timeInterval / 3600) / 12
        }
    }
    
    var tickerScale: CGFloat {
        switch type {
        case .second:
            return 0.8
        case .minute:
            return 0.6
        case .hour:
            return 0.4
        }
    }
}
