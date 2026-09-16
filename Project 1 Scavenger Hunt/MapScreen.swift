import SwiftUI
import MapKit

struct MapScreen: View {
    @Binding var coordinate: ScavengerItem.Coordinate?
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // Annotation items for the map
    var annotationItems: [MapAnnotationItem] {
        if let coordinate = coordinate {
            return [MapAnnotationItem(coordinate: coordinate.clLocationCoordinate)]
        }
        return []
    }
    
    var body: some View {
        VStack {
            
            // Map with annotation
            Map(coordinateRegion: $region, annotationItems: annotationItems) { item in
                MapMarker(coordinate: item.coordinate)
            }
            .frame(height: 300)
            
            // Save current map center as item coordinate
            Button("Set This Location") {
                coordinate = ScavengerItem.Coordinate(
                    latitude: region.center.latitude,
                    longitude: region.center.longitude
                )
            }
            .padding()
        }
        .navigationTitle("Map")
        
        // Center map on saved coordinate
        .onAppear {
            if let coordinate = coordinate {
                region.center = coordinate.clLocationCoordinate
            }
        }
    }
}

// Annotation wrapper
struct MapAnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
