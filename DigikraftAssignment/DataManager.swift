//
//  DataManager.swift
//  DigikraftAssignment
//
//  Created by Ajay Awasthi on 31/05/22.
//
import Foundation
import Combine

final class DataManager {

    static let shared = DataManager()
    private var session: URLSession


    init() {
        session = URLSession.init(configuration: URLSessionConfiguration.default)
        session.configuration.timeoutIntervalForRequest = 30
    }

    func dataFetch(url: String) -> AnyPublisher <BikeStationResponseModel, Error> {
        guard let url = URL.init(string: url) else {
            return Fail(error: NSError(domain: "Invalid url", code: -1000, userInfo: nil)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .decode(type: BikeStationResponseModel.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}
