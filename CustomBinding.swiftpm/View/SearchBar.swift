import SwiftUI

struct SearchBar: View {

    @Binding var text: String
    @State private var isEditing = false
    
    private var searchText: Binding<String> {
        Binding<String>(
            get: {
                self.text.capitalized
            }, set: {
                self.text = $0
            }
        )
    }

    var body: some View {
        HStack {
            TextField("Search ...", text: searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button {
                                self.text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
            
            if isEditing {
                Button {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing)) 
            }
        }
    }
}
            
#Preview {
    SearchBar(text: .constant(""))
}
