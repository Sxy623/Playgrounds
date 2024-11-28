import SwiftUI

struct ContentView: View {
    
    @Namespace private var shapeTransition
    @State private var expand = false
    
    var body: some View {
        VStack {
            if expand {
                Spacer()
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
                    .padding()
                    .foregroundStyle(.green)
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.orange)
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }
                Spacer()
            }
        }
    }
}
