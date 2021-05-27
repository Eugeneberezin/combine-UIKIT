//
//  JobModel.swift
//  Combine+UIKIT
//
//  Created by Eugene Berezin on 5/26/21.
//

import Foundation

struct Job: Codable {
    
    var type: String?
    var url: String?
    var createdAt: String?
    var company: String
    var companyUrl: String?
    var location: String?
    var title: String
    var description: String?
    var howToApply: String?
    var companyLogo: String?
}
