//
//  ErrorEntry.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation

struct ErrorEntry: Codable {
    let error_type: String
    let details: String
    let priority: String
}
