//
//  Constants.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 25.09.2023.
//

import UIKit

struct ConstantsLayout {
    static let leftDistanceToView: CGFloat = 20
    static let rightDistanceToView: CGFloat = 20
    
    //menu
    static let menuMinimumLineSpacing: CGFloat = 10
    static let menuItemWidth = (UIScreen.main.bounds.width - ConstantsLayout.leftDistanceToView - ConstantsLayout.rightDistanceToView - (ConstantsLayout.menuMinimumLineSpacing / 3)) / 3
    
    //submenu
    static let subMenuMinimumLineSpacing: CGFloat = 20
    static let subMenuItemWidth = (UIScreen.main.bounds.width - ConstantsLayout.leftDistanceToView - ConstantsLayout.rightDistanceToView - ConstantsLayout.subMenuMinimumLineSpacing) / 2
    static let subMenuCellCount = UIScreen.main.bounds.width / subMenuItemWidth
    static let margin = subMenuMinimumLineSpacing * 2
}

struct ConstantsString {
    static let titleName = "VKUSSOVET"
    static let imageName = "logo"
    static let buttonName = "phone"
}
