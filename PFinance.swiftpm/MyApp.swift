import SwiftUI
import SwiftData

@main
struct PFinanceApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
        .modelContainer(for: PaymentActivity.self)
    }
}
