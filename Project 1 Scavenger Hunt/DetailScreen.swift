import SwiftUI
import PhotosUI
import MapKit

struct DetailScreen: View {
    @Binding var item: ScavengerItem
    
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        VStack(spacing: 25) {
            
            //Banner
            if item.isCompleted {
                Text("Completed")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.bottom, 10)
            }
            
            //Photo Picker
            PhotosPicker("Choose Photo", selection: $selectedPhoto, matching: .images)
            
            //Display Photo
            if let data = item.photoData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 4)
            }
            
            
            //Notes
            TextField("Enter notes...", text: $item.notes)
                .textFieldStyle(.roundedBorder)
            
            //Map Navigation
            NavigationLink("Open Map") {
                MapScreen(coordinate: $item.coordinate)
            }
            
            //Mark Completed
            Button("Mark Completed") {
                item.isCompleted = true
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle(item.name)
        .onChange(of: selectedPhoto) { newItem in
            Task {
                if let newItem {
                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                        item.photoData = data
                    }
                }
            }
        }
    }
}
