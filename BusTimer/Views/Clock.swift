//
//  Clock.swift
//  BusTimer
//
//  Created by Docent HG on 23/07/2024.
//

import SwiftUI


struct Clock: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length = rect.width / 2
        let innerRadius = length-10
        let center = CGPoint(x: rect.midX, y: rect.midY)
        for index in 0..<60 {
            let radian = Angle(degrees: Double(index) * 6 - 90).radians
            let lineHeight: Double = index % 5 == 0 ? 25 : 10
            
            let x1 = center.x + innerRadius * cos(radian)
            let y1 = center.y + innerRadius * sin(radian)
            
            let x2 = center.x + (innerRadius - lineHeight) * cos(radian)
            let y2 = center.y + (innerRadius - lineHeight) * sin(radian)
            
            path.move(to: .init(x: x1, y: y1))
            path.addLine(to: .init(x: x2, y: y2))
        }
        
        
        return path
    }
    
}

struct ClockHand: Shape {
    var model: ClockTickerModel
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length = rect.width / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)

        path.move(to: center)
        let hoursAngle = CGFloat.pi / 2 - .pi * 2 * model.angleMultiplier
        path.addLine(to: CGPoint(x: rect.midX + cos(hoursAngle) * length * model.tickerScale,
                                 y: rect.midY - sin(hoursAngle) * length * model.tickerScale))
        return path
    }
}
