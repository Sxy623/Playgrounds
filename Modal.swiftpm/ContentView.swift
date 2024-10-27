import SwiftUI

struct ContentView: View {
    
    @State var selectedArticle: Article?
    
    var body: some View {
        NavigationStack {
            List(articles) { article in
                ArticleRow(article: article)
                    .onTapGesture {
                        self.selectedArticle = article
                    }
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Your Reading")
            .sheet(item: $selectedArticle) { article in
                ArticleDetailView(article: article)
            }
        }
    }
}
