//
//  ConfigModel.swift
//  AsurionTest
//
//  Created by amit on 27/08/22.
//

import Foundation

// MARK: - ConfigModel
struct ConfigModel: Codable {
    let settings: Settings
}

// MARK: - Settings
struct Settings: Codable {
    let isChatEnabled, isCallEnabled: Bool
    let workHours: String
}
