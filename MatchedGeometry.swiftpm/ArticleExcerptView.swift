import SwiftUI

struct ArticleExcerptView: View {
    
    @Binding var showDetail: Bool
    var articleTransition: Namespace.ID
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image("latte")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .matchedGeometryEffect(id: "image", in: articleTransition)
                    .cornerRadius(10)
                    .padding()
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2)) {
                            showDetail.toggle()
                        }
                    }
                
                Text("The Watertower is a full-service restaurant/cafe located in the Sweet Auburn District of Atlanta.")
                    .matchedGeometryEffect(id: "text", in: articleTransition)
                    .padding([.horizontal, .bottom])
            }
        }
    }
}
