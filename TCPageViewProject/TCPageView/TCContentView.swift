//
//  TCContentView.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

@objc protocol TCContentViewDelegate: class {
    @objc optional func contentView(contentView: TCContentView, visableItmeIndex: Int)
}

fileprivate let kUICollectionViewCellIdenfier = "UICollectionViewCell"

class TCContentView: UIView {
    
    // MARK: 属性
    
    /// 代理
    weak var delegate: TCContentViewDelegate?
    
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

extension TCContentView {
    
    /// 设置滚动结果
    fileprivate func collectionViewDidEndScroll() {
        let index = collectionView.contentOffset.x / collectionView.bounds.width
        delegate?.contentView?(contentView: self, visableItmeIndex: Int(index))
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            collectionViewDidEndScroll()
        }
    }
}

// MARK: TCHeaderViewDelegate
extension TCContentView: TCHeaderViewDelegate {
    
    func headerView(_ headerView: TCHeaderView, currentIndex: Int) {
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        print(currentIndex)
    }
}
