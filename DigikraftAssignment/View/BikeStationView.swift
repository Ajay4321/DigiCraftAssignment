//
//  ContentView.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 31/05/22.
//

import SwiftUI

struct BikeStationView: View {
    @StateObject var viewModel = BikeStationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack (spacing: .zero) {
                    ForEach (viewModel.bikeStation) { bikeStation in
                        NavigationLink {
                            MapView(uiModel: bikeStation)
                        } label: {
                            BikeStationCell(uiModel: bikeStation)
                        }
                    }
                    .padding([.leading, .bottom, .trailing], 10)
                }
            }
            .navigationTitle(Constants.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .clipped()
        .ignoresSafeArea(edges: [.bottom])
        .onAppear { [weak viewModel] in
            viewModel?.onAppear()
        }
    }
}

struct BikeStationView_Previews: PreviewProvider {
    static var previews: some View {
        BikeStationView()
    }
}
