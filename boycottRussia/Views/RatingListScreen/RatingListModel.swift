//
//  RatingListModel.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.07.2022.
//

import Foundation

struct Rating: Codable, Identifiable {
    var id: String
    let name: String
    let rating: Int
}
