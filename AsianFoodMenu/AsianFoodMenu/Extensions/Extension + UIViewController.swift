//
//  Extension + UIViewController.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 24.09.2023.
//

import UIKit

extension UIViewController {
    
    var screenSize: CGFloat {
        UIScreen.main.bounds.width
    }
    
    func createNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
    }
    
    func createCustomTitleView(
        titleName: String,
        imageName: String,
        buttonName: String,
        selector: Selector) -> UIView {
            
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: screenSize, height: 60)
        
        let logoImage = UIImageView(image: UIImage(named: imageName))
        logoImage.frame = CGRect(x: 5, y: 0, width: 60, height: 60)
        logoImage.contentMode = .scaleAspectFit
        logoImage.clipsToBounds = true
        logoImage.layer.cornerRadius = logoImage.frame.height / 2
        logoImage.backgroundColor = .clear
        view.addSubview(logoImage)
        
        let title = UILabel()
        title.text = titleName
        title.frame = CGRect(x: logoImage.frame.width + 10, y: 0, width: 250, height: 60)
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.textColor = .white
        view.addSubview(title)
        
        let button = UIButton()
        button.frame = CGRect(x: screenSize - 90, y: 0, width: 40, height: 60)
        button.setImage(UIImage(systemName: buttonName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.tintColor = .white
        view.addSubview(button)
            
        return view
    }
}
