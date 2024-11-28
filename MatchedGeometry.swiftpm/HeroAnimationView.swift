import SwiftUI

struct HeroAnimationView: View {
    
    @Namespace private var articleTransition
    @State private var showDetail = false
    
    var body: some View {
        if !showDetail {
            ArticleExcerptView(showDetail: $showDetail, articleTransition: articleTransition)
        }
        
        if showDetail {
            ArticleDetailView(showDetail: $showDetail, articleTransition: articleTransition)
        }
    }
}

#Preview {
    HeroAnimationView()
}
