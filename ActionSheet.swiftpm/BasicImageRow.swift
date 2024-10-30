import SwiftUI

struct BasicImageRow: View {
    
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
            
            if restaurant.isCheckIn {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.red)
            }
            
            if restaurant.isFavorite {
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
    }
}
