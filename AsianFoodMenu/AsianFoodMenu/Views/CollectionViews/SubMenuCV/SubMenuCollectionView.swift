//
//  SubMenuCollectionView.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 25.09.2023.
//

import UIKit

class SubMenuCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.subMenuMinimumLineSpacing
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupSelf()
        contentInset = UIEdgeInsets(
            top: 0,
            left: Constants.leftDistanceToView,
            bottom: 0,
            right: Constants.rightDistanceToView
        )
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 10, left: Constants.leftDistanceToView, bottom: 20, right: Constants.rightDistanceToView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
        backgroundColor = #colorLiteral(red: 0.1411764324, green: 0.1411764324, blue: 0.1411764324, alpha: 1)
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(SubMenuCollectionViewCell.self, forCellWithReuseIdentifier: SubMenuCollectionViewCell.reuseID)
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension SubMenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubMenuCollectionViewCell.reuseID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.subMenuItemWidth, height: Constants.subMenuItemWidth * 1.4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        55
    }
}
