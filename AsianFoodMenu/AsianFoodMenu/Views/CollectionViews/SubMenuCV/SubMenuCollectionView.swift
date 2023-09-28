//
//  SubMenuCollectionView.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 25.09.2023.
//

import UIKit

class SubMenuCollectionView: UICollectionView {

    private let subMenuProvider = SubMenuProvider()
    private var subMenu: SubMenu?
    
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
        contentInset = UIEdgeInsets(top: 10, left: Constants.leftDistanceToView, bottom: 30, right: Constants.rightDistanceToView)
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
    
    private func fetchSubMenu(by id: String) async {
        do {
            let subMenu = try await subMenuProvider.fetchSubMenu(by: id)
            self.subMenu = subMenu
            self.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension SubMenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        subMenu?.menuList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubMenuCollectionViewCell.reuseID, for: indexPath) as! SubMenuCollectionViewCell
        if let subMenu = subMenu?.menuList[indexPath.row] {
            cell.setupWith(subMenuList: subMenu)
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.subMenuItemWidth, height: Constants.subMenuItemWidth * 1.4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        55
    }
}

extension SubMenuCollectionView: MenuCollectionViewSubMenuDelegate {

    func fetchSubMenu(from menu: Menu, at index: Int) {
        let id = menu.menuList[index].menuID
        print(id)
        Task {
            await fetchSubMenu(by: id)
        }
    }   
}
