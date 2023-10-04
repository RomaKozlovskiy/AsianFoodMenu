//
//  SubMenuProvider.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 23.09.2023.
//

import Foundation

class SubMenuProvider: Provider {
    
    private let subMenuRouter = SubMenuRouter()
    private var subMenu: SubMenu?
    private let formBodyKey = "menuID"
    
    func fetchSubMenu(by id: String) async throws -> SubMenu? {
        let route = subMenuRouter.subMenuRoute()
        let data = try await self.request(withRoute: route, formBody: [formBodyKey: id])
        let subMenu = try self.decode(subMenu.self, data: data)
        return subMenu
    }
}
