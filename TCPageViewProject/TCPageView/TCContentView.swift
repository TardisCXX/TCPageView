//
//  TCContentView.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

class TCContentView: UIView {
    
    // MARK: 属性
    
    var childControllers: [UIViewController]

    // MARK: 构造函数
    
    init(frame: CGRect, childControllers: [UIViewController]) {
        self.childControllers = childControllers
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
