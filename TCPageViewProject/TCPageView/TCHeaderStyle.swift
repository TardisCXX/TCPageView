//
//  TCHeaderStyle.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

class TCHeaderStyle {
    
    // MARK: 属性
    
    /// 设置titleView高
    var headerHeight: CGFloat = 44.0
    /// 文字普通状态颜色
    var normalColor: UIColor = UIColor.white
    /// 文字当前选中颜色
    var selectColor: UIColor = UIColor.orange
    /// 文字字体
    var titleFont: CGFloat = 14.0
    /// 文字lbl间距
    var titleMargin: CGFloat = 30.0
    
    /// 是否滚动
    var isScroll: Bool = false
    
    /// 是否显示底部线条
    var isShowBottomLine: Bool = false
    /// 底部线条颜色
    var bottomLineColor: UIColor = UIColor.orange
    var bottomLineHeight: CGFloat = 2.0
    
    /// 文字是否需要缩放
    var isScaleEnabel: Bool = false
    /// 缩放最大值
    var maxScale: CGFloat = 1.2
}
