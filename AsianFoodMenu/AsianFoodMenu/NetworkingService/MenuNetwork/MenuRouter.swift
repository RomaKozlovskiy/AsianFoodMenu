//
//  MenuRouter.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 23.09.2023.
//

import Foundation

class MenuRouter: ApiRouterProtocol {
    func menuRoute() -> ApiRoute {
        var baseUrl = self.apiRoute()
        baseUrl.method = .post
        baseUrl.urlComponents?.path = ApiPath.getMenu.rawValue
        return baseUrl
    }
}
