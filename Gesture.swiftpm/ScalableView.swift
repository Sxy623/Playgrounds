import SwiftUI

struct ScalableView<Content>: View where Content: View {
    
    @GestureState private var scaleFactor: CGFloat = 1.0
    
    var content: () -> Content
    
    var body: some View {
        content()
            .scaleEffect(scaleFactor)
            .animation(.default, value: scaleFactor)
            .gesture(
                MagnificationGesture()
                    .updating($scaleFactor) { (value, state, transaction) in
                        state = value
                    }
            )
    }
}

#Preview {
    ScalableView {
        Image(systemName: "headphones")
            .font(.system(size: 100))
            .foregroundStyle(.purple)
    }
}