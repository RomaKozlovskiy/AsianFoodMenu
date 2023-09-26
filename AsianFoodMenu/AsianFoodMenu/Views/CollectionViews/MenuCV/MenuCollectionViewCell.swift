//
//  MenuCollectionViewCell.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 24.09.2023.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "MenuCollectionViewCell"
    
    // MARK: - Private lazy properties
    
    private lazy var menuImageView: UIImageView = _menuImageView
    private lazy var foodNameLabel: UILabel = _foodName
    private lazy var foodCountLabel: UILabel = _foodCount
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSelf()
        addSubviews()
        applyConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureSelf() {
        
        backgroundColor = #colorLiteral(red: 0.2579315901, green: 0.2629087567, blue: 0.2671231627, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func addSubviews() {
        addSubview(menuImageView)
        addSubview(foodNameLabel)
        addSubview(foodCountLabel)
    }
    
    private func applyConstraints() {
    
        NSLayoutConstraint.activate([
            menuImageView.topAnchor.constraint(equalTo: topAnchor),
            menuImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2),
            
            foodNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodNameLabel.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 10),
            
            
            foodCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodCountLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 5)
            
        ])
    }
}

private extension MenuCollectionViewCell {
    
    var _menuImageView : UIImageView {
        let result = UIImageView()
        result.backgroundColor = .white
        result.contentMode = .scaleAspectFit
        result.image = UIImage(named: "logo")
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodName: UILabel {
        let result = UILabel(frame: .zero)
        result.textColor = .white
        result.text = "Суши"
        result.font = UIFont.boldSystemFont(ofSize: 18)
        result.textAlignment = .center
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodCount: UILabel {
        let result = UILabel()
        result.textColor = #colorLiteral(red: 0.5411763787, green: 0.5411765575, blue: 0.5454813838, alpha: 1)
        result.text = "7 товаров"
        result.font = UIFont.systemFont(ofSize: 14)
        result.textAlignment = .center
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
}
