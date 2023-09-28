//
//  Extension + Data.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 28.09.2023.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
