import SwiftUI

struct ContentView: View {
    @State private var counter = 1
    
    var body: some View {
        VStack {
            CounterButton(counter: $counter, color: .blue)
            CounterButton(counter: $counter, color: .green)
            CounterButton(counter: $counter, color: .red)
        }
    }
}
