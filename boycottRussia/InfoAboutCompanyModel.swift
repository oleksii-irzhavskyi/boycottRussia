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
//    static var placeholder: Self{
//        return InfoAboutCompanyElement(id: nil, name: nil, status: nil, updatedAt: nil, products: nil)
//    }
}

// MARK: - Product
struct Product: Codable {
    let name: String
}

typealias CompanyInfo = [CompanyInfoElement]
