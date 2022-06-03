//
//  BikeStationViewModel.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 31/05/22.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

final class BikeStationViewModel: ObservableObject {

    @Published var bikeStation: [BikeStationUIModel] = []
    @Published var isLoading: Bool = false
    private var locationManager = LocationManager.shared
    private var items: [BikeFeature] = []
    private var subscribers = Set<AnyCancellable>()

    func onAppear() {
        locationManager.startUpdating()
        updateUserLocation()
        isLoading = true
        DataManager.shared
            .dataFetch(url: Constants.url)
            .sink {[weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] result in
                self?.items = result.features
                self?.updateList(currentLocation: self?.locationManager.location ?? CLLocation())
            }.store(in: &subscribers)
    }
    
    private func updateUserLocation(){
        locationManager.currentLocataion.sink {[weak self] currenValue in
            self?.updateList(currentLocation: currenValue)
        }.store(in: &subscribers)
    }

    private func updateList(currentLocation: CLLocation) {
        bikeStation = items.map { $0.toUIModel(currentLocation.coordinate)}
    }
}
