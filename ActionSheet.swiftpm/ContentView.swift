import SwiftUI

struct ContentView: View {
    
    @State var restaurants = [
        Restaurant(name: "Cafe Deadend", image: "cafedeadend"),
        Restaurant(name: "Homei", image: "homei"),
        Restaurant(name: "Teakha", image: "teakha"),
        Restaurant(name: "Cafe Loisl", image: "cafeloisl"),
        Restaurant(name: "Petite Oyster", image: "petiteoyster"),
        Restaurant(name: "For Kee Restaurant", image: "forkeerestaurant"),
        Restaurant(name: "Po's Atelier", image: "posatelier"),
        Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery"),
        Restaurant(name: "Haigh's Chocolate", image: "haighschocolate"),
        Restaurant(name: "Palomino Espresso", image: "palominoespresso"),
        Restaurant(name: "Homei", image: "upstate"),
        Restaurant(name: "Traif", image: "traif"),
        Restaurant(name: "Graham Avenue Meats And Deli", image: "grahamavenuemeats"),
        Restaurant(name: "Waffle & Wolf", image: "wafflewolf"),
        Restaurant(name: "Five Leaves", image: "fiveleaves"),
        Restaurant(name: "Cafe Lore", image: "cafelore"),
        Restaurant(name: "Confessional", image: "confessional"),
        Restaurant(name: "Barrafina", image: "barrafina"),
        Restaurant(name: "Donostia", image: "donostia"),
        Restaurant(name: "Royal Oak", image: "royaloak"),
        Restaurant(name: "CASK Pub and Kitchen", image: "caskpubkitchen")
    ]
    
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        List {
            ForEach(restaurants) { restaurant in
                BasicImageRow(restaurant: restaurant)
                    .contextMenu {
                        Button {
                            self.checkIn(item: restaurant)
                        } label: {
                            HStack {
                                Text("Check-in")
                                Image(systemName: "checkmark.seal.fill")
                            }
                        }
                        
                        Button {
                            self.delete(item: restaurant)
                        } label: {
                            HStack {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                        
                        Button{
                            self.setFavorite(item: restaurant)
                        } label: {
                            HStack {
                                Text("Favorite")
                                Image(systemName: "star")
                            }
                        }
                    }
                    .onTapGesture {
                        self.selectedRestaurant = restaurant
                    }
                    .actionSheet(item: self.$selectedRestaurant) { restaurant in
                        ActionSheet(title: Text("What do you want to do"), message: nil, buttons: [
                            .default(Text("Mark as Favorite"), action: {
                                self.setFavorite(item: restaurant)
                            }),
                            .destructive(Text("Delete"), action: {
                                self.delete(item: restaurant)
                            }),
                            .cancel()
                        ])
                    }
            }
            .onDelete { (indexSet) in
                self.restaurants.remove(atOffsets: indexSet)
            }
        }
        .listStyle(.plain)
    }
    
    private func delete(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants.remove(at: index)
        }
    }
    
    private func setFavorite(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants[index].isFavorite.toggle()
        }
    }
    
    private func checkIn(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants[index].isCheckIn.toggle()
        }
    }
}
