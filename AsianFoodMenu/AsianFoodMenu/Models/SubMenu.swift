//
//  SubMenu.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 22.09.2023.
//

import Foundation

struct SubMenu: Decodable {
    let status: Bool
    var menuList: [SubMenuList]
}

struct SubMenuList: Decodable {
   let id: String
   let image: String
   let name: String
   let content: String
   let price: String
   let weight: String?
   let spicy: String?
  }


