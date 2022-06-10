//
//  InfoAboutCompanyModel.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 21.05.2022.
//

import Foundation

struct CompanyInfoElement: Codable {
    let id: Int?
    let name, status, updatedAt: String?
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let name: String
}

typealias CompanyInfo = [CompanyInfoElement]
