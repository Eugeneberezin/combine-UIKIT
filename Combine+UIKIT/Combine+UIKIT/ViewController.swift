//
//  ViewController.swift
//  Combine+UIKIT
//
//  Created by Eugene Berezin on 5/26/21.
//
import Combine
import UIKit

class ViewController: UIViewController {
    var anyCancelable = Set<AnyCancellable>()
    var job = [Job]()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        fetchJobs()
    }
    
    private func fetchJobs() {
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
                self.job = jobs
                self.tableView.reloadData()
                
            }
            .store(in: &anyCancelable)

    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return job.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = job[indexPath.row].company
        return cell
    }
    
    
}

