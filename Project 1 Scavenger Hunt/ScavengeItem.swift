import SwiftUI
import MapKit

struct ScavengerItem: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    
    var photoData: Data?
    var notes: String = ""
    var coordinate: Coordinate?
    var isCompleted: Bool = false
    
    static func == (lhs: ScavengerItem, rhs: ScavengerItem) -> Bool {
        lhs.id == rhs.id
    }
    
    struct Coordinate: Codable, Equatable {
        var latitude: Double
        var longitude: Double
        
        var clLocationCoordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
}
