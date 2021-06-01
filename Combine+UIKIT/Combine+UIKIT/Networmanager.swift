//
//  Networmanager.swift
//  Combine+UIKIT
//
//  Created by Eugene Berezin on 5/26/21.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    var anyCancelable = Set<AnyCancellable>()
    
    func getResults(description: String, location: String) -> AnyPublisher<[Job], Error> {
        
        let urlString = "https://jobs.github.com/positions.json?description=\(description.replacingOccurrences(of: " ", with: "+"))&location=\(location.replacingOccurrences(of: " ", with: "+"))"
         let url = URL(string: urlString)!
        
        let decoder = JSONDecoder()
        
        return Future {[weak self] promise in
            guard let self = self else {return}
            URLSession.shared.dataTaskPublisher(for: url)
                .retry(1)
                .mapError {$0}
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: [Job].self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    
                } receiveValue: { jobs in
                    promise(.success(jobs))
                }
                .store(in: &self.anyCancelable)
        }
        .eraseToAnyPublisher()
        
        
    }
}
