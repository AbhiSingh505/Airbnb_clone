import SwiftUI
import MapKit

struct MapExploreView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var cameraPosition: MapCameraPosition
    @State private var annotations: [PlaceAnnotation]
    @State private var displayed: [DisplayAnnotation]
    
    init() {
        let initial = CLLocationCoordinate2D(latitude: 11.9416, longitude: 79.8083) // Puducherry
        _cameraPosition = State(initialValue: .region(MKCoordinateRegion(center: initial, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))))
        let anns = MapExploreView.defaultAnnotations()
        _annotations = State(initialValue: anns)
        _displayed = State(initialValue: MapExploreView.cluster(anns, span: 0.5))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                ForEach(displayed) { ann in
                    Annotation(ann.title, coordinate: ann.coordinate) {
                        let isCluster: Bool = Int(ann.title) != nil
                        badgeView(title: ann.title, isCluster: isCluster)
                            .onTapGesture {
                                if isCluster {
                                    let newDelta: CLLocationDegrees = 0.1
                                    let region = MKCoordinateRegion(
                                        center: ann.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: newDelta, longitudeDelta: newDelta)
                                    )
                                    withAnimation(.easeInOut) {
                                        cameraPosition = .region(region)
                                    }
                                }
                            }
                    }
                }
            }
            .ignoresSafeArea()
            .tabBarHidden(true)
            
            // Top controls
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Theme.textPrimary)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        annotations.shuffle()
                        displayed = MapExploreView.cluster(annotations, span: 0.5)
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "slider.horizontal.3")
                        Text("Filters")
                    }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Theme.textPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }
}

// MARK: - Models
struct PlaceAnnotation: Identifiable {
    let id = UUID()
    let title: String
    let priceLabel: String
    let coordinate: CLLocationCoordinate2D
}

struct DisplayAnnotation: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
}

// MARK: - Defaults
extension MapExploreView {
    static func defaultAnnotations() -> [PlaceAnnotation] {
        [
            PlaceAnnotation(title: "Puducherry", priceLabel: "₹3,251", coordinate: .init(latitude: 11.9416, longitude: 79.8083)),
            PlaceAnnotation(title: "Auroville", priceLabel: "₹2,009", coordinate: .init(latitude: 12.0057, longitude: 79.8104)),
            PlaceAnnotation(title: "Chennai", priceLabel: "₹7,500", coordinate: .init(latitude: 13.0827, longitude: 80.2707)),
            PlaceAnnotation(title: "Goa (Anjuna)", priceLabel: "₹6,500", coordinate: .init(latitude: 15.5889, longitude: 73.7432)),
            PlaceAnnotation(title: "Manali", priceLabel: "₹4,200", coordinate: .init(latitude: 32.2432, longitude: 77.1892)),
            PlaceAnnotation(title: "Paris (Louvre)", priceLabel: "€89", coordinate: .init(latitude: 48.8606, longitude: 2.3376)),
            PlaceAnnotation(title: "Paris (Montmartre)", priceLabel: "€120", coordinate: .init(latitude: 48.8867, longitude: 2.3431))
        ]
    }
}

// MARK: - Clustering
extension MapExploreView {
    static func cluster(_ anns: [PlaceAnnotation], span: CLLocationDegrees) -> [DisplayAnnotation] {
        // Threshold grows with zoomed-out views
        let cell = max(0.05, min(0.6, span * 0.35))
        var buckets: [String: [PlaceAnnotation]] = [:]
        for a in anns {
            let key = gridKey(for: a.coordinate, cell: cell)
            buckets[key, default: []].append(a)
        }
        return buckets.values.map { group in
            if group.count == 1, let single = group.first {
                return DisplayAnnotation(title: single.priceLabel, coordinate: single.coordinate)
            } else {
                // Compute centroid
                let lat = group.map { $0.coordinate.latitude }.reduce(0, +) / Double(group.count)
                let lon = group.map { $0.coordinate.longitude }.reduce(0, +) / Double(group.count)
                return DisplayAnnotation(title: "\(group.count)", coordinate: .init(latitude: lat, longitude: lon))
            }
        }
    }
    
    private static func gridKey(for coord: CLLocationCoordinate2D, cell: CLLocationDegrees) -> String {
        let gx = Int(floor(coord.latitude / cell))
        let gy = Int(floor(coord.longitude / cell))
        return "\(gx)-\(gy)"
    }
}

// MARK: - Span helper (unused simplified version kept for reference)

@ViewBuilder
private func badgeView(title: String, isCluster: Bool) -> some View {
    Text(title)
        .font(.system(size: 12, weight: .semibold))
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    AnyShapeStyle(
                        isCluster
                        ? AnyShapeStyle(LinearGradient(colors: [Theme.primaryColor, Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                        : AnyShapeStyle(Color.white)
                    )
                )
        )
        .foregroundColor(isCluster ? Theme.onPrimary : Theme.textPrimary)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black.opacity(isCluster ? 0 : 0.1))
        )
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
}


