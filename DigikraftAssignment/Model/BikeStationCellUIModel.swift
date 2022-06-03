//
//  BikeStationCellUIModel.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 31/05/22.
//

import Foundation
import CoreLocation

struct BikeStationUIModel: Identifiable {
    let id: String
    let label: String
    let free_racks: Int
    let bikes: Int
    let bike_racks: Int
    let location: CLLocation
    let distance: CUnsignedLongLong
}
