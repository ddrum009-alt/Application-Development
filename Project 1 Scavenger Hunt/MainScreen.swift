import SwiftUI

struct MainScreen: View {
    @AppStorage("items") private var storedItemsData: Data = Data()
    @State private var items: [ScavengerItem] = []
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(items.indices, id: \.self) { index in
                    NavigationLink {
                        DetailScreen(item: $items[index])
                    } label: {
                        HStack {
                            Text(items[index].name)
                            Spacer()
                            if items[index].isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Scavenger Hunt")
            .toolbar {
                NavigationLink("Completed") {
                    CompletedScreen(items: items)
                }
            }
            
            // Load saved items
            .onAppear {
                if let decoded = try? JSONDecoder().decode([ScavengerItem].self, from: storedItemsData) {
                    items = decoded
                }
            }
            
            // Save items when changed
            .onChange(of: items) { newValue in
                if let encoded = try? JSONEncoder().encode(newValue) {
                    storedItemsData = encoded
                }
            }
        }
    }
}
