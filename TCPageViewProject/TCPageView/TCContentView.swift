//
//  TCContentView.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

fileprivate let kUICollectionViewCellIdenfier = "UICollectionViewCell"

class TCContentView: UIView {
    
    // MARK: 属性
    
    fileprivate var childControllers: [UIViewController]
    /// 根控制器
    fileprivate var rootController: UIViewController
    
    fileprivate lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()

    // MARK: 构造函数
    
    init(frame: CGRect, childControllers: [UIViewController], rootController: UIViewController) {
        self.childControllers = childControllers
        self.rootController = rootController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: UI
extension TCContentView {
    
    fileprivate func setupUI() {
        addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kUICollectionViewCellIdenfier)
        
        for vc in childControllers {
            rootController.addChildViewController(vc)
        }
    }
}

// MARK: UICollectionViewDataSource
extension TCContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kUICollectionViewCellIdenfier, for: indexPath)
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let vc = childControllers[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension TCContentView: UICollectionViewDelegate {
    
}
