//
//  TestView.swift
//  BusTimer
//
//  Created by Docent HG on 25/07/2024.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        return VStack {
            HeaderView()
            Spacer()
            ClockView()
            Spacer()
        }
    }
}

#Preview {
    TestView().environmentObject(CountDownTimer())
}
