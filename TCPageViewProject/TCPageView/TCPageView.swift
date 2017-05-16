//
//  TCPageView.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

protocol TCPageViewDataSource: class {
    
    // 设置展示section
    func numberOfSectionInPageView(_ pageView: TCPageView) -> Int
    // 设置设置每一个section里面的items
    func pageView(_ pageView: TCPageView, numberOfItemsInSection section: Int) -> Int
    // 设置cell
    func pageView(_ pageView: TCPageView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell
}

class TCPageView: UIView {

    // MARK: 属
    
    /// 设置数据源
    weak var dataSource: TCPageViewDataSource?
    
    /// 样式
    fileprivate var style: TCHeaderStyle
    /// 标题数组
    fileprivate var titles: [String]
    /// 控制器数组
    fileprivate var childControllers: [UIViewController]!
    /// 根控制器
    fileprivate var rootController: UIViewController!
    /// 布局
    fileprivate var layout: TCPageViewFlowLayout!
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var pageControl: UIPageControl!
    
    /// 当前section
    fileprivate lazy var currentSection: Int = 0
    
    fileprivate lazy var headerView: TCHeaderView = {
        let headerRect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.style.headerHeight)
        let headerView = TCHeaderView(frame: headerRect, sytle: self.style, titles: self.titles)
        headerView.backgroundColor = UIColor.brown
        
        return headerView
    }()
    
    // MARK: 构造函数
    
    init(frame: CGRect, style: TCHeaderStyle, titles: [String], childControllers: [UIViewController], rootController: UIViewController) {
        
        self.style = style
        self.titles = titles
        self.childControllers = childControllers
        self.rootController = rootController
        
        super.init(frame: frame)
        
        setupContentUI()
    }
    
    init(frame: CGRect, style: TCHeaderStyle, titles: [String], layout: TCPageViewFlowLayout) {
        self.style = style
        self.titles = titles
        self.layout = layout
        
        super.init(frame: frame)
        
        setupCollectionUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
extension TCPageView {
    
    /// 设置控制器UI
    fileprivate func setupContentUI() {
        addSubview(headerView)
        
        let contentRect = CGRect(x: 0, y: style.headerHeight, width: bounds.width, height: bounds.height - style.headerHeight)
        let contentView = TCContentView(frame: contentRect, childControllers: childControllers, rootController: rootController)
        addSubview(contentView)
        
        headerView.delegate = contentView
        contentView.delegate = headerView
        
    }
    
    /// 设置collectionView的UI
    fileprivate func setupCollectionUI() {
        addSubview(headerView)
        
        let collectionRect = CGRect(x: 0, y: style.headerHeight, width: bounds.width, height: bounds.height - style.headerHeight - style.pageControlHeight)
        collectionView = UICollectionView(frame: collectionRect, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubview(collectionView)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: collectionView.frame.maxY, width: bounds.width, height: style.pageControlHeight))
        pageControl.numberOfPages = 1
        pageControl.hidesForSinglePage = true
        pageControl.isEnabled = false
        pageControl.tintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        addSubview(pageControl)
        
        headerView.delegate = self
    }
}

// MARK: TCHeaderViewDelegate
extension TCPageView: TCHeaderViewDelegate {
    
    func headerView(_ headerView: TCHeaderView, currentIndex: Int) {
        let indexPath = IndexPath(item: 0, section: currentIndex)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left
        
        let itemCount = dataSource?.pageView(self, numberOfItemsInSection: currentIndex) ?? 0
        pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
        pageControl.currentPage = 0
        
        currentSection = currentIndex
    }
}

// MARK:UICollectionViewDataSource
extension TCPageView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSectionInPageView(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = dataSource?.pageView(self, numberOfItemsInSection: section) ?? 0
        if section == 0 {
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
            pageControl.currentPage = 0
        }
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageView(self, cellForItemAtIndexPath: indexPath)
    }
}

// MARK: UICollectionViewDelegate
extension TCPageView: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            collectionViewDidEndScroll()
        }
    }
}

// MARK: private
extension TCPageView {
    
    fileprivate func collectionViewDidEndScroll() {
//        guard let cell = collectionView.visibleCells.last,
//        let indexPath = collectionView.indexPath(for: cell) else {
//            return
//        }
        
        let point = CGPoint(x: layout.sectionInset.left + collectionView.contentOffset.x, y: layout.sectionInset.top)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        
        if currentSection != indexPath.section {
            let itemCount = dataSource?.pageView(self, numberOfItemsInSection: indexPath.section) ?? 0
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
            pageControl.currentPage = 0
            currentSection = indexPath.section
            
            // 修改headerView标题滚动位置
            headerView.setCurrentIndex(currentIndex: currentSection)
        }
        
        let pageIndex = indexPath.item / (layout.cols * layout.rows)
        pageControl.currentPage = pageIndex
    }

}

// MARK: public
extension TCPageView {
    
    /// 注册cell
    func registerCell(_ cellClass: AnyClass?, identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    /// 注册 cell
    func registerNib(_ nib: UINib?, identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    /// 循环复用cell
    func dequeueReusableCell(reuseIdentifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
}




