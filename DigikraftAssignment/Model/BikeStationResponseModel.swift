//
//  BikeStationResponseModel.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 01/06/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct BikeStationResponseModel: Codable {
    let features: [BikeFeature]
}

struct BikeFeature: Codable {
    let geometry: BikeGeometry
    let id: String
    let properties: BikeProperty
}

struct BikeGeometry: Codable {
    let coordinates: [Double]
}

struct BikeProperty: Codable {
    let free_racks: String
    let bikes: String
    let label: String
    let bike_racks: String
}

extension BikeFeature {
    func toUIModel(_ currentLocation: CLLocationCoordinate2D?) -> BikeStationUIModel {
        var mapLocation = CLLocation()
        if let latitude = geometry.coordinates.first, let longitude = geometry.coordinates.last {
            mapLocation = CLLocation(latitude: latitude, longitude: longitude)
        }
        return BikeStationUIModel(
            id: id,
            label: properties.label,
            free_racks: Int(properties.free_racks) ?? .zero,
            bikes: Int(properties.bikes) ?? .zero,
            bike_racks: Int(properties.bike_racks) ?? .zero,
            location: mapLocation,
            distance: CUnsignedLongLong(
                mapLocation.distance(
                    from:CLLocation(
                        latitude: currentLocation?.latitude ?? .zero,
                        longitude: currentLocation?.longitude ?? .zero
                    )
                )
            )
        )
    }
}
