//
//  MapView.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 01/06/22.
//

import SwiftUI
import MapKit

struct MapView: View {

    let uiModel: BikeStationUIModel
    @StateObject private var locationManager = LocationManager.shared
    @State private var tracking = MapUserTrackingMode.follow
    
    var body: some View {
        VStack (spacing: .zero) {
        Map(
            coordinateRegion: $locationManager.region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $tracking,
            annotationItems: [uiModel],
            annotationContent: { item in
                MapAnnotation(coordinate: item.location.coordinate) {
                    ZStack {
                        Color.white
                        Image(Constants.bike, bundle: Bundle.main)
                            .resizable()
                            .frame(width: Constants.imageSize, height: Constants.imageSize)
                    }
                    .frame(width: Constants.iconSize, height: Constants.iconSize)
                    .cornerRadius(10)
                }
            }
        )
            VStack (alignment: .leading) {
                Text(uiModel.label)
                    .foregroundColor(.black)
                    .font(.system(size: Constants.titleFont))
                    .fontWeight(.bold)
                    .padding(.top, 20)
                Text(uiModel.distance > 2000 ?
                     String(format: "%.1f km%@", Float(uiModel.distance)/1000.0, Constants.bikeStand):
                        String(uiModel.distance) + " m" + Constants.bikeStand
                )
                    .foregroundColor(.black.opacity(0.6))
                    .font(.system(size: Constants.normalFont))
                    .fontWeight(.regular)
                HStack {
                    VStack {
                        Image(Constants.bike, bundle: Bundle.main)
                            .resizable()
                            .frame(width: Constants.iconSize, height: Constants.iconSize)
                        Text(Constants.availableBike)
                            .foregroundColor(.black.opacity(0.6))
                            .font(.system(size: Constants.normalFont))
                        Text(String(uiModel.bikes))
                            .foregroundColor(.green)
                            .font(.system(size: Constants.boldFont))
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Image(Constants.lock, bundle: Bundle.main)
                            .resizable()
                            .frame(width: Constants.iconSize, height: Constants.iconSize)
                        Text(Constants.availablePlaces)
                            .foregroundColor(.black.opacity(0.6))
                            .font(.system(size:  Constants.normalFont))
                        Text(String(uiModel.free_racks))
                            .foregroundColor(.black)
                            .font(.system(size:  Constants.boldFont))
                            .fontWeight(.bold)
                    }
                }
                .padding( .all, 20)
            }
            .padding([.leading, .trailing], 20)
            .background(Color.white)
        }
            .ignoresSafeArea()
            .onAppear {
                locationManager.pinLocation = uiModel.location
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            uiModel: BikeStationUIModel(
                id: "1",
                label: "Default Stand",
                free_racks: 20,
                bikes: 10,
                bike_racks: 10,
                location: CLLocation(),
                distance: 100
            )
        )
    }
}
