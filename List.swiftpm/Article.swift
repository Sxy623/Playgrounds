import SwiftUI

struct Article: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var rating: Int
    var excerpt: String
    var image: String
}
