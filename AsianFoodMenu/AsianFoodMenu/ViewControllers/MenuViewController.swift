//
//  ViewController.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 21.09.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let imageView = UIImageView(image: UIImage(systemName: "phone.fill"))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(
            red: 0.1411764324,
            green: 0.1411764324,
            blue: 0.1411764324,
            alpha: 1)
        
        setupNavigationItem()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationItem() {
        createNavigationBar()
        
        let customTitleView = createCustomTitleView(
            titleName: "VKUSSOVET",
            imageName: "logo",
            buttonName: "phone",
            selector: #selector(test)
        )
        
        navigationItem.titleView = customTitleView
    }
    
     @objc private func test() {
        print(#function)
    }
}













/*
 
 private func setupUI() {
 navigationController?.navigationBar.prefersLargeTitles = true
 
 title = "VKUSSOVET"
 
 // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
 guard let navigationBar = self.navigationController?.navigationBar else { return }
 navigationBar.addSubview(imageView)
 imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
 imageView.clipsToBounds = true
 imageView.translatesAutoresizingMaskIntoConstraints = false
 NSLayoutConstraint.activate([
 imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
 imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
 imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
 imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
 ])
 }
 
 private struct Const {
 /// Image height/width for Large NavBar state
 static let ImageSizeForLargeState: CGFloat = 40
 /// Margin from right anchor of safe area to right anchor of Image
 static let ImageRightMargin: CGFloat = 16
 /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
 static let ImageBottomMarginForLargeState: CGFloat = 12
 /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
 static let ImageBottomMarginForSmallState: CGFloat = 6
 /// Image height/width for Small NavBar state
 static let ImageSizeForSmallState: CGFloat = 32
 /// Height of NavBar for Small state. Usually it’s just 44
 static let NavBarHeightSmallState: CGFloat = 44
 /// Height of NavBar for Large state. Usually it’s just 96.5 but if you have a custom font for
 ///the title, please make sure to edit this value since it changes the height for Large state of NavBar
 static let NavBarHeightLargeState: CGFloat = 96.5
 }
 
 */
