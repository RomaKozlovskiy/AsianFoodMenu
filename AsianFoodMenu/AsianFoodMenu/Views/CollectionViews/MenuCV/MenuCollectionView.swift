//
//  MenuCollectionView.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 24.09.2023.
//

import UIKit

// MARK: - Protocols

protocol MenuCollectionViewDelegate: AnyObject {
    func fetchFoodName(from menu: Menu, at index: Int)
}

protocol MenuCollectionViewSubMenuDelegate: AnyObject {
    func fetchSubMenu(from menu: Menu, at index: Int)
}

class MenuCollectionView: UICollectionView {
    
    // MARK: - weak Delegates properties
    
    weak var menuDelegate: MenuCollectionViewDelegate?
    weak var subMenuDelegate: MenuCollectionViewSubMenuDelegate?
    
    // MARK: - Private properties
    private let menuProvider = MenuProvider()
    private var menu: Menu?
    
    //logical properties
    private var currentIndexPath: Int = 0
    
    // MARK: - init
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupSelf()
        layout.minimumLineSpacing = ConstantsLayout.menuMinimumLineSpacing
        contentInset = UIEdgeInsets(
            top: 0,
            left: ConstantsLayout.leftDistanceToView,
            bottom: 0,
            right: ConstantsLayout.rightDistanceToView
        )
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        Task {
            await fetchMenu()
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
    
    private func fetchMenu() async {
        do {
            let menu = try await menuProvider.fetchMenu()
            self.menu = menu
            if let menu = menu {
                subMenuDelegate?.fetchSubMenu(from: menu, at: 0)
                menuDelegate?.fetchFoodName(from: menu, at: 0)
            }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentIndexPath != indexPath.row {
            guard let menu = menu else { return }
            subMenuDelegate?.fetchSubMenu(from: menu, at: indexPath.row)
            menuDelegate?.fetchFoodName(from: menu, at: indexPath.row)
        }
        
        currentIndexPath = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: ConstantsLayout.menuItemWidth, height: frame.height)
    }
}

