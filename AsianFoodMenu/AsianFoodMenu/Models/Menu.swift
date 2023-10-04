//
//  Menu.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 22.09.2023.
//

import Foundation

struct Menu: Decodable {
    let status: Bool
    let menuList: [MenuList]
}

struct MenuList: Decodable {
    let menuID: String
    let image: String
    let name: String
    let subMenuCount: Int
}
