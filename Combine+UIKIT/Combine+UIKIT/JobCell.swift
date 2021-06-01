//
//  JobCell.swift
//  Combine+UIKIT
//
//  Created by Eugene Berezin on 5/31/21.
//

import UIKit

class JobCell: UITableViewCell {
    
    static let reuseIdentifier = "JobCell"
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emplymentTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    func configureUI() {
        
        let vStack = UIStackView(arrangedSubviews: [companyLabel,positionLabel, emplymentTypeLabel])
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.spacing = 0
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.layer.cornerRadius = 6
        vStack.backgroundColor = .systemGray5
        
        contentView.addSubview(vStack)
        
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(with job: Job) {
        companyLabel.text = "Company: \(job.company)"
        positionLabel.text = job.title
        emplymentTypeLabel.text = job.type
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
