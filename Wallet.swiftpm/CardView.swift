import SwiftUI

struct CardView: View {
    
    var card: Card
    
    var body: some View {
        Image(card.image)
            .resizable()
            .scaledToFit()
            .frame(width: 594, height: 375)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text(card.number)
                        .bold()
                    HStack {
                        Text(card.name)
                            .bold()
                        Text("Valid Thru")
                            .font(.footnote)
                        Text(card.expiryDate)
                            .font(.footnote)
                    }
                }
                .foregroundStyle(.white)
                .padding(.leading, 25)
                .padding(.bottom, 20)
            }
            .shadow(color: .gray, radius: 1.0, x: 0.0, y: 1.0)
    }
}

#Preview {
    ForEach(testCards) { card in
        CardView(card: card)
    }
}
