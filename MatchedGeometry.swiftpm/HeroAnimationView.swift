import SwiftUI

struct HeroAnimationView: View {
    
    @Namespace private var articleTransition
    @State private var showDetail = false
    
    var body: some View {
        if !showDetail {
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
        
        if showDetail {
            ScrollView {
                VStack {
                    Image("latte")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 400)
                        .clipped()
                        .matchedGeometryEffect(id: "image", in: articleTransition)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.4)) {
                                showDetail.toggle()
                            }
                        }
                    Text("The Watertower is a full-service restaurant/cafe located in the Sweet Auburn District of Atlanta. The restaurant features a full menu of moderately priced \"comfort\" food influenced by African and French cooking traditions, but based upon time honored recipes from around the world. The cafe section of The Watertower features a coffeehouse with a dessert bar, magazines, and space for live performers.\n\nThe Watertower will be owned and operated by The Watertower LLC, a Georgia limited liability corporation managed by David N. Patton IV, a resident of the Empowerment Zone. The members of the LLC are David N. Patton IV (80%) and the Historic District Development Corporation (20%).\n\nThis business plan offers financial institutions an opportunity to review our vision and strategic focus. It also provides a step-by-step plan for the business start-up, establishing favorable sales numbers, gross margin, and profitability.\n\nThis plan includes chapters on the company, products and services, market focus, action plans and forecasts, management team, and financial plan.")
                        .matchedGeometryEffect(id: "text", in: articleTransition)
                        .animation(nil, value: showDetail)
                        .padding(.all, 20)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    HeroAnimationView()
}
