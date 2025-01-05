//
//  RefreshView.swift
//  BusTimer
//
//  Created by Docent HG on 24/07/2024.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var timer: CountDownTimer
    
    var body: some View {
        return HStack {
            Text("Hello, World!").font(.title)
            Spacer()
            Button (action: { Task { await timer.refesh()} }) { Label("Refresh", systemImage: "arrow.clockwise")
            }.font(.title).labelStyle(.iconOnly)
        }
        .padding()
        
    }
}

#Preview {
    HeaderView().environmentObject(CountDownTimer())
}
