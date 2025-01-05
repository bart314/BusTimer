//
//  ClockView.swift
//  BusTimer
//
//  Created by Docent HG on 23/07/2024.
//

import SwiftUI

struct ClockView: View {
    @EnvironmentObject var timer:CountDownTimer
    
    var body: some View {
        return ZStack {
            Clock()
                .stroke(Color.cyan, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

            ClockHand(model: .init(type: .hour, timeInterval: timer.seconds, tickScale: 0.4))
            .stroke(Color.primary, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            
            ClockHand(model: .init(type: .minute, timeInterval: timer.seconds, tickScale: 0.6))
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            
            ClockHand(model: .init(type: .second, timeInterval: timer.seconds, tickScale: 0.8))
            .stroke(Color.red, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            
        }.frame(width: 200, height: 200, alignment: .center)
            .task {
                await timer.refesh()
            }
    }
}

#Preview {
    ClockView()
        .environmentObject(CountDownTimer())
        .environmentObject(APIClient())
}
