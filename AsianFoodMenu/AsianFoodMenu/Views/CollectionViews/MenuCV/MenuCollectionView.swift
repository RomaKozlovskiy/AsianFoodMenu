//
//  MenuCollectionView.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 24.09.2023.
//

import UIKit

class MenuCollectionView: UICollectionView {
    
    // MARK: - Private properties
    
    private let menuProvider = MenuProvider()
    private var menu: Menu?
    
    // MARK: - init
    
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
        
        Task {
            await fetchData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupSelf() {
        backgroundColor = #colorLiteral(red: 0.1411764324, green: 0.1411764324, blue: 0.1411764324, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseId)
    }
    
    private func fetchData() async {
        do {
            let menu = try await menuProvider.fetchMenu()
            self.menu = menu
            self.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menu?.menuList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.reuseId,
            for: indexPath) as! MenuCollectionViewCell
        
        if let menuList = menu?.menuList[indexPath.row] {
            cell.setupWith(menuList: menuList)
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.menuItemWidth, height: frame.height)
    }
}

