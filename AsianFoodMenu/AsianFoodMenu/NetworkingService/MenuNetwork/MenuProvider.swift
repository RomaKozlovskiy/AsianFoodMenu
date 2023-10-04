//
//  MenuProvider.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 23.09.2023.
//

import Foundation

class MenuProvider: Provider {
    
    private let menuRouter = MenuRouter()
    private var menu: Menu?
    
    func fetchMenu() async throws -> Menu? {
        let route = menuRouter.menuRoute()
        let data = try await self.request(withRoute: route)
        let menu = try self.decode(menu.self, data: data)
        return menu
    }
}
