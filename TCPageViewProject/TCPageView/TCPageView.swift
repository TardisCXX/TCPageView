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
    var style: TCHeaderStyle
    /// 标题数组
    var titles: [String]
    /// 控制器数组
    var childControllers: [UIViewController]
    
    // MARK: 构造函数
    
    init(frame: CGRect, style: TCHeaderStyle, titles: [String], childControllers: [UIViewController]) {
        
        self.style = style
        self.titles = titles
        self.childControllers = childControllers
        
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
extension TCPageView {
    
    fileprivate func setupUI() {
        let headerRect = CGRect(x: 0, y: 0, width: bounds.width, height: 44.0)
        let titleView = TCHeaderView(frame: headerRect, sytle: style, titles: titles)
        titleView.backgroundColor = UIColor.brown
        addSubview(titleView)
        
        let content 
        let contentView = TCContentView(frame: <#T##CGRect#>, childControllers: <#T##[UIViewController]#>)
        
    }
}




