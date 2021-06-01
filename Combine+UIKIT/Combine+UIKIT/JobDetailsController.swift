//
//  JobDetailsController.swift
//  Combine+UIKIT
//
//  Created by Eugene Berezin on 5/31/21.
//

import UIKit
import Combine

class JobDetailsController: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private var anyCancelables = Set<AnyCancellable>()
    
    var job = PassthroughSubject<Job, Never>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configure() {
        job
            .sink {[weak self] job in
                self?.label.text = job.company
            }
            .store(in: &anyCancelables)
    }
    
    private func configureUI(){
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    


}
