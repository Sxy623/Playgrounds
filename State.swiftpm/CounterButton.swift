import SwiftUI

struct CounterButton: View {
    @Binding var counter: Int
    
    var color: Color
    
    var body: some View {
        Button {
            counter += 1
        } label: {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(color)
                .overlay {
                    Text("\(counter)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
        }
    }
}
