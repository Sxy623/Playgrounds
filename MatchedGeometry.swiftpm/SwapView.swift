import SwiftUI

struct SwapView: View {
    
    @Namespace private var dotTransition
    @State private var swap = false
    
    var body: some View {
        if swap {
            HStack {
                Circle()
                    .fill(.green)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
                Spacer()
                Circle()
                    .fill(.orange)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
            }
            .frame(width: 100)
            .onTapGesture {
                withAnimation {
                    swap.toggle()
                }
            }
            
        } else {
            HStack {
                Circle()
                    .fill(.orange)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
                Spacer()
                Circle()
                    .fill(.green)
                    .frame(width: 30, height: 30)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
            }
            .frame(width: 100)
            .onTapGesture {
                withAnimation {
                    swap.toggle()
                }
            }
        }
    }
}

#Preview {
    SwapView()
}
