import SwiftUI

struct CompletedScreen: View {
    let items: [ScavengerItem]
    
    var body: some View {
        List {
            ForEach(items.filter { $0.isCompleted }) { item in
                Text(item.name)
            }
        }
        .navigationTitle("Completed Items")
    }
}
test
