import SwiftUI

struct HelloWorldView: View {
    var body: some View {
        Button {
            print("Hello World tapped!")
        } label: {
            Text("Hello World")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
                .background(.purple)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.purple, lineWidth: 5)
                }
        }
    }
}

#Preview {
    HelloWorldView()
}
