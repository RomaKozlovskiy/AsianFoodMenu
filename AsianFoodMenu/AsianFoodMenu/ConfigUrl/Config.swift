//
//  baseUrl.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 21.09.2023.
//

import Foundation

struct Config {
  
    static let baseStringUrl = Bundle.main.infoDictionary![Key.baseUrl.rawValue] as? String
   
     var baseUrl: URLComponents? {
         if let baseStringUrl = Config.baseStringUrl {
            let baseUrl = URLComponents(string: baseStringUrl)
            return baseUrl
        }
        return nil
    }
   
    private enum Key: String {
        case baseUrl
    }
}

enum ApiPath: String {
    case getMenu = "/api/getMenu.php"
    case getSubMenu = "/api/getSubMenu.php"
}

