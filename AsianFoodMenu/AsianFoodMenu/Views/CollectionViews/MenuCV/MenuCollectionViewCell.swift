//
//  MenuCollectionViewCell.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 24.09.2023.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static properties
    
    static var reuseId: String {
        get {
            "MenuCollectionViewCell"
        }
    }
    
    // MARK: - Override properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = #colorLiteral(red: 0.274024725, green: 0.3874692917, blue: 1, alpha: 1)
            } else {
                backgroundColor = #colorLiteral(red: 0.2579315901, green: 0.2629087567, blue: 0.2671231627, alpha: 1)
            }
        }
    }
    
    // MARK: - Private properties
    
    private let menuProvider = MenuProvider()
    
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
    
    // MARK: - Public properties
    
    func setupWith(menuList: MenuList) {
        Task {
            let image = await setImage(from: menuList)
            await MainActor.run{
                menuImageView.image = image
            }
        }
        foodNameLabel.text = menuList.name
        foodCountLabel.text = "\(menuList.subMenuCount) товаров"
    }
    
    // MARK: - Private Methods
    
    private func configureSelf() {
        backgroundColor = #colorLiteral(red: 0.2579315901, green: 0.2629087567, blue: 0.2671231627, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = false
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
            
            foodNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            foodNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            foodNameLabel.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 10),
            foodNameLabel.heightAnchor.constraint(equalToConstant: 37),
            
            foodCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodCountLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor)
            
        ])
    }
        
    private func setImage(from menuList: MenuList) async -> UIImage? {
        do {
            let image = try await menuProvider.fetchFoodImage(from: menuList.image)
            return image
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

// MARK: - Private extension MenuCollectionViewCell

private extension MenuCollectionViewCell {
    
    var _menuImageView : UIImageView {
        let result = UIImageView()
        result.backgroundColor = #colorLiteral(red: 0.5411763787, green: 0.5411765575, blue: 0.5454813838, alpha: 1)
        result.contentMode = .scaleAspectFill
        result.clipsToBounds = true
        result.layer.cornerRadius = 10
        result.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodName: UILabel {
        let result = UILabel(frame: .zero)
        result.textColor = .white
        result.font = UIFont.boldSystemFont(ofSize: 18)
        result.textAlignment = .center
        result.numberOfLines = 2
        result.adjustsFontSizeToFitWidth = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _foodCount: UILabel {
        let result = UILabel()
        result.textColor = #colorLiteral(red: 0.5411763787, green: 0.5411765575, blue: 0.5454813838, alpha: 1)
        result.font = UIFont.systemFont(ofSize: 14)
        result.textAlignment = .center
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
}
