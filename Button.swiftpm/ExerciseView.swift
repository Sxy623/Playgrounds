import SwiftUI

struct ExerciseView: View {
    var body: some View {
        Button {
            print("Plus button tapped")
        } label: {
            Image(systemName: "plus")
        }
        .buttonStyle(CircularStyle())
    }
}

struct CircularStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(Color.purple)
            .clipShape(Circle())
            .rotationEffect(configuration.isPressed ? Angle(degrees: 135) : Angle(degrees: 0))
    }
}

#Preview {
    ExerciseView()
}
