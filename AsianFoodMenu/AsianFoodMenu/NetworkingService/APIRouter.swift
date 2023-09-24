//
//  APIRoute.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 21.09.2023.
//

import Foundation

protocol ApiRouterProtocol {
    func apiRoute() -> ApiRoute
    var config: Config { get }
}

struct ApiRoute {
    var urlComponents: URLComponents?
    var method: Method
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

extension ApiRouterProtocol {
    var config: Config {
        return Config()
    }
    
    func apiRoute() -> ApiRoute {
         ApiRoute(urlComponents: config.baseUrl, method: .get)
    }
}


