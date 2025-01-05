// publish / subscribe in Swift:
// https://developer.apple.com/documentation/combine/publishers/map

// publishing every interval
// https://developer.apple.com/documentation/foundation/timer/3329589-publish

// binding
// https://developer.apple.com/documentation/swiftui/binding




import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        return VStack {
            Spacer()
            ClockView()
            Spacer()
            ClockView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}

