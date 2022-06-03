//
//  LocationManager.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 01/06/22.
//

import Foundation
import CoreLocation
import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    var currentLocataion: PassthroughSubject<CLLocation,Never>
    static let shared = LocationManager()
    private let manager: CLLocationManager
    var pinLocation: CLLocation? {
        didSet {
            resetRegion(lastKnownLocation: location)
        }
    }

    @Published var location: CLLocation = CLLocation()
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: .zero, longitude:.zero),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    override private init() {
        manager = CLLocationManager()
        manager.activityType = .fitness
        currentLocataion = PassthroughSubject<CLLocation,Never>()
    }

    func startUpdating() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        guard let lastKnownLocation = locations.first else {
            return
        }
        location = lastKnownLocation
        currentLocataion.send(location)
        resetRegion(lastKnownLocation: lastKnownLocation)
    }

    private func resetRegion(lastKnownLocation: CLLocation) {
        let location2D = CLLocationCoordinate2D(
            latitude: lastKnownLocation.coordinate.latitude,
            longitude: lastKnownLocation.coordinate.longitude
        )

        if let pinLocation = pinLocation {
            let latitudeDistance = getDistance(first: CLLocation(latitude: lastKnownLocation.coordinate.latitude, longitude: 0), second: CLLocation(latitude: pinLocation.coordinate.latitude, longitude: 0))
            let longitudeDistance = getDistance(first: CLLocation(latitude: 0, longitude: lastKnownLocation.coordinate.longitude), second: CLLocation(latitude: 0, longitude: pinLocation.coordinate.longitude))
            region = MKCoordinateRegion(center: location2D, latitudinalMeters: latitudeDistance, longitudinalMeters: longitudeDistance)
        } else {
            region = MKCoordinateRegion(
                center: location2D,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }

    private func getDistance(first: CLLocation, second: CLLocation) -> CLLocationDistance {
        let distance = first.distance(from:second)
        return distance * 3
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
