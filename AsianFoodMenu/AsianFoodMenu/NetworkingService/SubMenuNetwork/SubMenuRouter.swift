//
//  SubMenuRouter.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 23.09.2023.
//

import Foundation

class SubMenuRouter: ApiRouterProtocol {
    func subMenuRoute() -> ApiRoute {
        var baseRoute = self.apiRoute()
        baseRoute.method = .post
        baseRoute.urlComponents?.path = ApiPath.getSubMenu.rawValue
        return baseRoute
    }
}
