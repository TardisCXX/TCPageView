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
    /// 底部线条的高
    var bottomLineHeight: CGFloat = 2.0
    
    /// 文字是否需要缩放
    var isScaleEnabel: Bool = false
    /// 缩放最大值
    var maxScale: CGFloat = 1.2
    
    /// 是否显示遮罩
    var isShowCover: Bool = false
    /// 遮罩背景颜色
    var coverBackgroundColor: UIColor = UIColor.black
    /// 遮罩透明度
    var coverAlpha:CGFloat = 0.4
    /// 遮罩间隙
    var coverMargin: CGFloat = 8.0
    /// 遮罩的高
    var coverHeight: CGFloat = 25.0
    /// 遮罩的圆角半径
    var coverRadius: CGFloat = 12.0
    
    
    // MARK: ------------------
    
    /// pageControl的高度
    var pageControlHeight: CGFloat = 20.0
    
}
