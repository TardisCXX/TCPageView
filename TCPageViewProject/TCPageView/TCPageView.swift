//
//  TCPageView.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

class TCPageView: UIView {

    // MARK: 属性
    
    /// 样式
    fileprivate var style: TCHeaderStyle
    /// 标题数组
    fileprivate var titles: [String]
    /// 控制器数组
    fileprivate var childControllers: [UIViewController]
    /// 根控制器
    fileprivate var rootController: UIViewController
    
    // MARK: 构造函数
    
    init(frame: CGRect, style: TCHeaderStyle, titles: [String], childControllers: [UIViewController], rootController: UIViewController) {
        
        self.style = style
        self.titles = titles
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
extension TCPageView {
    
    fileprivate func setupUI() {
        let headerRect = CGRect(x: 0, y: 0, width: bounds.width, height: 44.0)
        let headerView = TCHeaderView(frame: headerRect, sytle: style, titles: titles)
        headerView.backgroundColor = UIColor.brown
        addSubview(headerView)
        
        let contentRect = CGRect(x: 0, y: style.headerHeight, width: bounds.width, height: bounds.height - style.headerHeight)
        let contentView = TCContentView(frame: contentRect, childControllers: childControllers, rootController: rootController)
        addSubview(contentView)
        
        headerView.delegate = contentView
        contentView.delegate = headerView
        
    }
}




