//
//  JobsViewModel.swift
//  Combine+UIKIT
//
//  Created by Eugene Berezin on 5/31/21.
//

import Foundation
import Combine

class JobsViewModel {
    @Published var jobs = [Job]()
    
    private var anyCancelable = Set<AnyCancellable>()
    
    init() {}
    
    func fetchJobs() {
        NetworkManager.shared.getResults(description: "", location: "")
            .receive(on: DispatchQueue.main)
            .map{$0}
            .sink { completion in
                
                switch completion {
                
                case .finished:
                    print("Done")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] jobs in
                guard let self = self else {return}
                self.jobs = jobs
            }
            .store(in: &anyCancelable)
    }
    
}
