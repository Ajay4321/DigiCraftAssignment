//
//  BikeStationCell.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 31/05/22.
//

import SwiftUI
import CoreLocation

struct BikeStationCell: View {
    let uiModel: BikeStationUIModel

    var body: some View {
        VStack (alignment: .leading) {
            Text(uiModel.label)
                .foregroundColor(.black)
                .font(.system(size: Constants.titleFont))
                .fontWeight(.bold)
                .padding(.top, 10)
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
                        .font(.system(size: Constants.normalFont))
                    Text(String(uiModel.free_racks))
                        .foregroundColor(.black)
                        .font(.system(size: Constants.boldFont))
                        .fontWeight(.bold)
                }
            }
            .padding(
                EdgeInsets(
                    top: 10,
                    leading: 40,
                    bottom: 10,
                    trailing: 40
                )
            )
        }
        .padding([.leading, .trailing], 20)
        .background(Color.white)
        .cornerRadius(10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 1)
    }
}

struct BikeStationCell_Previews: PreviewProvider {
    static var previews: some View {
        BikeStationCell(
            uiModel:
                BikeStationUIModel(
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
