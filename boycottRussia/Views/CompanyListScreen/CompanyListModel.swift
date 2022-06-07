//
//  CompanyListModel.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 04.06.2022.
//

import Foundation

struct CompanyList: Codable {
    let records: [Record]
    let offset: String?
    
    enum CodingKeys: String, CodingKey{
        case records = "records"
        case offset = "offset"
    }
}

// MARK: - Record
struct Record: Codable, Identifiable {
    let id, createdTime: String
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable {
    let name: String
    let logo: [Logo]
    let grade: String
    let country, action, dateOfLastAction: String?
    let linkToAnnouncement: String?
    let gicsIndustrySector, magnitudeOfRussianOperations: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case logo = "Logo"
        case grade = "Grade"
        case country = "Country"
        case action = "Action"
        case dateOfLastAction = "Date of Last Action"
        case linkToAnnouncement = "Link to Announcement"
        case gicsIndustrySector = "GICS Industry Sector"
        case magnitudeOfRussianOperations = "Magnitude of Russian Operations"
    }
}

// MARK: - Logo
struct Logo: Codable {
    let id: String
    let width, height: Int
    let url: String
    let filename: String
    let size: Int
    let type: String
    let thumbnails: Thumbnails
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let small, large, full: Full
}

// MARK: - Full
struct Full: Codable {
    let url: String
    let width, height: Int
}
struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String?
    var items: [Bookmark]?
}
