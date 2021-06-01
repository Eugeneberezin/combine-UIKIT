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
    let viewModel = JobsViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(JobCell.self, forCellReuseIdentifier: JobCell.reuseIdentifier)
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
        viewModel.fetchJobs()
        viewModel.$jobs
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &anyCancelable)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobCell.reuseIdentifier, for: indexPath) as! JobCell
        viewModel.$jobs
            .receive(on: DispatchQueue.main)
            .sink { jobs in
                cell.configureCell(with: jobs[indexPath.row])
            }
            .store(in: &anyCancelable)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
}

