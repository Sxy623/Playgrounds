import SwiftUI

struct ExerciseView: View {
    @State private var counterBlue = 0
    @State private var counterGreen = 0
    @State private var counterRed = 0
    
    var body: some View {
        VStack {
            Text("\(counterBlue + counterGreen + counterRed)")
                .font(.system(size: 220, weight: .bold, design: .rounded))
            
            HStack {
                CounterButton(counter: $counterBlue, color: .blue)
                CounterButton(counter: $counterGreen, color: .green)
                CounterButton(counter: $counterRed, color: .red)
            }
        }
    }
}

#Preview {
    ExerciseView()
}
