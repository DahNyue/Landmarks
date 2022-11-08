//
//  MapView.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI
import MapKit

struct MapLocation: Identifiable {
    let id: UUID = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapView: View {
    
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    var mapLoc: [MapLocation] = []
    
    @State private var region = MKCoordinateRegion()
    
    init(name: String, coordinate: CLLocationCoordinate2D, region: MKCoordinateRegion = MKCoordinateRegion()) {
        self.name = name
        self.coordinate = coordinate
        self.region = region
        self.mapLoc = [MapLocation(name: name, latitude: coordinate.latitude, longitude: coordinate.longitude)]
    }
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: nil, annotationItems: self.mapLoc, annotationContent: { mapLocation in
            MapPin(coordinate: mapLocation.coordinate, tint: .orange)
        })
        .onAppear {
            setRegion(coordinate)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.00628, longitudeDelta: 0.00628)
        )
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(name: "(주)캐스트폭스", coordinate: CLLocationCoordinate2D(latitude: 37.484565584152335, longitude: 126.98246906203757))
    }
}
