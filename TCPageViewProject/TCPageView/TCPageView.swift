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
    func pageView(_ pageView: TCPageView, cellForItemAtIndexPath: IndexPath) -> UICollectionViewCell
}

fileprivate let kUICollectionViewCellIdentifier = "UICollectionViewCell"

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
    
    fileprivate var layout: TCPageViewFlowLayout!
    
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
        let collectionView = UICollectionView(frame: collectionRect, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kUICollectionViewCellIdentifier)
        
        addSubview(collectionView)
        
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: collectionView.frame.maxY, width: bounds.width, height: style.pageControlHeight))
        pageControl.numberOfPages = 4
        
        addSubview(pageControl)
    }
}

// MARK:UICollectionViewDataSource
extension TCPageView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSectionInPageView(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.pageView(self, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageView(self, cellForItemAtIndexPath: indexPath)
    }
}




