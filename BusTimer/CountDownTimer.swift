//
//  TimeService.swift
//  BusTimer
//
//  Created by Docent HG on 23/07/2024.
//

import Foundation
import Combine
import SwiftUI


class CountDownTimer:ObservableObject {
    private var targetDate: Date = Date()
    @Published var seconds: TimeInterval = 0

    private var store = Set<AnyCancellable>()
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @EnvironmentObject var apiclient:APIClient

    init() {
    }
    
    public func refesh() async {
//        do {
//            let apiResponse:[BusTijdResponse] = try await self.apiclient.fetchData()
//            
//        } catch {
//            let errorMessage = error.localizedDescription
//            print (errorMessage)
//        }
        
        self.targetDate = Date().addingTimeInterval(200)
        
        timer
            .map { [weak self] _ in
                // Calculate the remaining time
                guard let self = self else { return 0 }
                let remaining = self.targetDate.timeIntervalSinceNow
                return max(0, remaining)
            }
            .assign(to: \.seconds, on: self).store(in: &store)
    }
    
    deinit {
        store.forEach { $0.cancel() }
    }
}

/*
 final class CurrentTime: ObservableObject {
     @Published var seconds: TimeInterval = CurrentTime.currentSecond(date: Date())

     private let timer = Timer.publish(every: 0.2, on: .main, in: .default).autoconnect()
     private var store = Set<AnyCancellable>()

     init() {
         timer.map(Self.currentSecond).assign(to: \.seconds, on: self).store(in: &store)
     }

     private static func currentSecond(date: Date) -> TimeInterval {
         let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
         let referenceDate = Calendar.current.date(from: DateComponents(year: components.year!, month: components.month!, day: components.day!))!
         return Date().timeIntervalSince(referenceDate)
     }
 }

 */
