import SwiftUI

struct SettingView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedOrder = 0
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    
    private var displayOrders = ["Alphabetical", "Show Favorite First", "Show Check-in First"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                    Picker(selection: $selectedOrder, label: Text("Display order")) {
                        ForEach(0 ..< displayOrders.count, id: \.self) {
                            Text(self.displayOrders[$0])
                        }
                    }
                }
                Section(header: Text("FILTER PREFERENCE")) {
                    Toggle(isOn: $showCheckInOnly) {
                        Text("Show Check-in Only")
                    }
                    
                    Stepper {
                        Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
                    } onIncrement: {
                        self.maxPriceLevel += 1
                        if self.maxPriceLevel > 5 {
                            self.maxPriceLevel = 5
                        }
                    } onDecrement: {
                        self.maxPriceLevel -= 1
                        if self.maxPriceLevel < 1 {
                            self.maxPriceLevel = 1
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                            .foregroundStyle(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}
    
#Preview {
    SettingView()
}
