import SwiftUI

struct ExerciseView: View {
    var body: some View {
        NavigationStack {
            List(articles) { article in
                ZStack {
                    ArticleRow(article: article)
                    
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Your Reading")
        }
        
    }
}

#Preview {
    ExerciseView()
}
