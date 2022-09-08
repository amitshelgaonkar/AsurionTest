//
//  PetModel.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import Foundation
// MARK: - PetModel
struct PetModel: Codable {
    let pets: [Pet]?
}

// MARK: - Pet
struct Pet: Codable {
    let imageURL: String
    let title: String
    let contentURL: String
    let dateAdded: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case title
        case contentURL = "content_url"
        case dateAdded = "date_added"
    }
}
