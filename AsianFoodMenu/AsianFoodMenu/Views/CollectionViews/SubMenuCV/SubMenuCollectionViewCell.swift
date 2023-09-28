//
//  SubMenuCollectionViewCell.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 25.09.2023.
//

import UIKit

class SubMenuCollectionViewCell: UICollectionViewCell {
    
    static var reuseID: String {
        get {
            "SubMenuCollectionViewCell"
        }
    }
    
    // MARK: - Private lazy properties
    
    private let subMenuProvider = SubMenuProvider()
    
    private lazy var subMenuImageView: UIImageView = _subMenuImageView
    private lazy var foodNameTitle: UILabel = _foodNameTitle
    private lazy var foodNameSubtitle: UILabel = _foodNameSubtitle
    private lazy var foodPrice: UILabel = _foodPrice
    private lazy var spicyImageView: UIImageView = _spicyImageView
    private lazy var addToCartButton: UIButton = _addToCartButton
    
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
    // MARK: - Public properties
    
    func setupWith(subMenuList: SubMenuList) {
        Task {
            let image = await setImage(from: subMenuList)
            await MainActor.run{
                subMenuImageView.image = image
            }
            foodNameTitle.text = subMenuList.name
            foodNameSubtitle.text = subMenuList.content
            foodPrice.attributedText = formatted(with: subMenuList.price, and: subMenuList.weight)
            if subMenuList.spicy != nil {
                spicyImageView.isHidden = false
            } else {
                spicyImageView.isHidden = true
            }
        }
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
            foodNameTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            foodNameTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            foodNameSubtitle.topAnchor.constraint(equalTo: foodNameTitle.bottomAnchor, constant: 5),
            foodNameSubtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            foodNameSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            foodPrice.bottomAnchor.constraint(equalTo: subMenuImageView.topAnchor, constant: -5),
            foodPrice.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            foodPrice.heightAnchor.constraint(equalToConstant: 20),
            
            spicyImageView.centerYAnchor.constraint(equalTo: subMenuImageView.topAnchor, constant: -15),
            spicyImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            spicyImageView.heightAnchor.constraint(equalToConstant: 40),
            spicyImageView.widthAnchor.constraint(equalToConstant: 40),
            
            addToCartButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.widthAnchor.constraint(equalToConstant: frame.width - 30),
            addToCartButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setImage(from subMenuList: SubMenuList) async -> UIImage? {
        do {
            let imageUrl = subMenuList.image
            let image = try await subMenuProvider.fetchFoodImage(from: imageUrl)
            return image
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
  
    private func formatted(with price: String?, and weight: String?) -> NSAttributedString {
        
        let rootString = NSMutableAttributedString()
        
        let priceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.white]
        let weightAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.gray]
        
        let doublePrice = Double(price ?? "")
        let strRoundedPice = String(format: "%.f", doublePrice ?? 0)
        
        let price = NSMutableAttributedString(string: strRoundedPice + " ₽ ", attributes: priceAttributes)
        rootString.append(price)
        
        if weight != nil {
            let weight = NSMutableAttributedString(string: "/ \(weight ?? "0").", attributes: weightAttributes)
            rootString.append(weight)
        }
        return rootString
    }
    
    @objc private func cartButton() {
        print(#function)
    }

}

// MARK: - Private extension

private extension SubMenuCollectionViewCell {
    var _subMenuImageView : UIImageView {
        let result = UIImageView()
        result.contentMode = .scaleAspectFill
        result.clipsToBounds = true
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodNameTitle: UILabel {
        let result = UILabel()
        result.textColor = .white
        result.font = UIFont.boldSystemFont(ofSize: 18)
        result.textAlignment = .center
        result.numberOfLines = 2
        result.adjustsFontSizeToFitWidth = true
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodNameSubtitle: UILabel {
        let result = UILabel()
        result.textColor = #colorLiteral(red: 0.5520539284, green: 0.5570270419, blue: 0.5569393635, alpha: 1)
        result.font = UIFont.boldSystemFont(ofSize: 12)
        result.textAlignment = .center
        result.numberOfLines = 2
        //result.adjustsFontSizeToFitWidth = true // todo
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodPrice: UILabel {
        let result = UILabel()
        result.textColor = .white
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
