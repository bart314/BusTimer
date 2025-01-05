//
//  BusTimerApp.swift
//  BusTimer
//
//  Created by Docent HG on 23/07/2024.
//
// zie ook https://designcode.io/swiftui-advanced-handbook-http-request

import SwiftUI

@main
struct BusTimerApp: App {
    let timer = CountDownTimer()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(timer)
        }
    }
}
