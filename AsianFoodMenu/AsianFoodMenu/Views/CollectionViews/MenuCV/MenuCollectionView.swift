//
//  MenuCollectionView.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 24.09.2023.
//

import UIKit

class MenuCollectionView: UICollectionView {
        
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupSelf()
        layout.minimumLineSpacing = Constants.menuMinimumLineSpacing
        contentInset = UIEdgeInsets(
            top: 0,
            left: Constants.leftDistanceToView,
            bottom: 0,
            right: Constants.rightDistanceToView
        )
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
        backgroundColor = #colorLiteral(red: 0.1411764324, green: 0.1411764324, blue: 0.1411764324, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseId)
    }
    
    @objc private func cartButton() {
        
    }
}



// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.menuItemWidth, height: frame.height)
    }
}

