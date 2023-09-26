//
//  SubMenuCollectionViewCell.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 25.09.2023.
//

import UIKit

class SubMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private lazy properties
    
    private lazy var subMenuImageView: UIImageView = _subMenuImageView
    private lazy var foodNameTitle: UILabel = _foodNameTitle
    private lazy var foodNameSubtitle: UILabel = _foodNameSubtitle
    private lazy var foodPrice: UILabel = _foodPrice
    private lazy var spicyImageView: UIImageView = _spicyImageView
    private lazy var addToCartButton: UIButton = _addToCartButton
    
    static let reuseID = "SubMenuCollectionViewCell"
    
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
    
    // MARK: - Override methods
    
    override func layoutSubviews() {
       // setBottomCornersRadius()
    }
    
  
    // MARK: - Private Methods
    
    private func configureSelf() {
        backgroundColor = .black
        clipsToBounds = false
        layer.cornerRadius = 10
    }

    private func addSubviews() {
        addSubview(subMenuImageView)
        addSubview(foodNameTitle)
        addSubview(foodNameSubtitle)
        addSubview(foodPrice)
        addSubview(spicyImageView)
        addSubview(addToCartButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            subMenuImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            subMenuImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subMenuImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            subMenuImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2),
            
            foodNameTitle.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            foodNameTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodNameTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            foodNameSubtitle.topAnchor.constraint(equalTo: foodNameTitle.bottomAnchor, constant: 5),
            foodNameSubtitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodNameSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            foodPrice.bottomAnchor.constraint(equalTo: subMenuImageView.topAnchor, constant: -15),
            foodPrice.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            foodPrice.heightAnchor.constraint(equalToConstant: 20),
            
            spicyImageView.centerYAnchor.constraint(equalTo: subMenuImageView.topAnchor, constant: -20),
            spicyImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            spicyImageView.heightAnchor.constraint(equalToConstant: 40),
            spicyImageView.widthAnchor.constraint(equalToConstant: 40),
            
            addToCartButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.widthAnchor.constraint(equalToConstant: frame.width - 30),
            addToCartButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
  
    @objc private func cartButton() {
        print(#function)
    }

}

// MARK: - Private extension

private extension SubMenuCollectionViewCell {
    var _subMenuImageView : UIImageView {
        let result = UIImageView()
        result.backgroundColor = .yellow
        result.contentMode = .scaleAspectFit
        result.image = UIImage(named: "logo")
        result.clipsToBounds = true
        result.layer.masksToBounds = false
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodNameTitle: UILabel {
        let result = UILabel()
        result.textColor = .white
        result.text = "Магура"
        result.font = UIFont.boldSystemFont(ofSize: 20)
        result.textAlignment = .center
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodNameSubtitle: UILabel {
        let result = UILabel()
        result.textColor = #colorLiteral(red: 0.5520539284, green: 0.5570270419, blue: 0.5569393635, alpha: 1)
        result.text = "Тунец"
        result.font = UIFont.boldSystemFont(ofSize: 14)
        result.textAlignment = .center
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodPrice: UILabel {
        let result = UILabel()
        result.textColor = .white
        result.textAlignment = .center
        result.text = "100 р / 50 г."
        result.font = UIFont.boldSystemFont(ofSize: 18)
        result.textAlignment = .center
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _spicyImageView: UIImageView {
        let result = UIImageView()
        result.backgroundColor = .clear
        result.contentMode = .scaleAspectFill
        result.image = UIImage(named: "spicy")
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _addToCartButton: UIButton {
        let result = UIButton()
        result.setTitle("В корзину", for: .normal)
        result.setTitleColor(.white, for: .normal)
        result.backgroundColor = #colorLiteral(red: 0.274024725, green: 0.3874692917, blue: 1, alpha: 1)
        result.layer.cornerRadius = 10
        result.addTarget(self, action: #selector(cartButton), for: .touchUpInside)
        result.layer.zPosition = .greatestFiniteMagnitude
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
       
        return result
    }
}