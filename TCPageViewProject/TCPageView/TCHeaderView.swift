//
//  TCHeaderView.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

class TCHeaderView: UIView {

    // MARK: 属性
    
    fileprivate var style: TCHeaderStyle
    fileprivate var titles: [String]
    
    // MARK: 构造函数
    
    init(frame: CGRect, sytle: TCHeaderStyle, titles: [String]) {
        self.style = sytle
        self.titles = titles
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
