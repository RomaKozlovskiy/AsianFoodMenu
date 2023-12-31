//
//  ViewController.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 21.09.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let menuCollectionView = MenuCollectionView()
    private let subMenuCollectionView = SubMenuCollectionView()
    private lazy var foodNameLabel: UILabel = _foodNameLabel
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1411764324, green: 0.1411764324, blue: 0.1411764324, alpha: 1)
        
        addSubviews()
        applyConstraints()
        setupNavigationItem()
        menuCollectionView.subMenuDelegate = subMenuCollectionView
        menuCollectionView.menuDelegate = self
    }

    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(menuCollectionView)
        view.addSubview(foodNameLabel)
        view.addSubview(subMenuCollectionView)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            menuCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            foodNameLabel.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor, constant: 20),
            foodNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsLayout.leftDistanceToView),
            foodNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ConstantsLayout.rightDistanceToView),
            
            subMenuCollectionView.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 5),
            subMenuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subMenuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subMenuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func setupNavigationItem() {
        createNavigationBar()
        
        let customTitleView = createCustomTitleView(
            titleName: ConstantsString.titleName,
            imageName: ConstantsString.imageName,
            buttonName: ConstantsString.buttonName,
            selector: #selector(callButtonDidTapped)
        )
        
        navigationItem.titleView = customTitleView
    }
    
     @objc private func callButtonDidTapped() {
        print(#function)
    }
}

// MARK: - Private Extensions

private extension MenuViewController {
    var _foodNameLabel: UILabel {
        let result = UILabel()
        result.font = UIFont.boldSystemFont(ofSize: 30)
        result.textColor = .white
        result.numberOfLines = 1
        result.adjustsFontSizeToFitWidth = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
}

// MARK: - MenuCollectionViewDelegate

extension MenuViewController: MenuCollectionViewDelegate {
    func fetchFoodName(from menu: Menu, at index: Int) {
        let foodName = menu.menuList[index].name
        foodNameLabel.text = foodName
    }
 
}







