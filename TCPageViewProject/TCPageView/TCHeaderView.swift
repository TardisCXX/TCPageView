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
    
    /// scrollView
    fileprivate lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    /// 标题标签数组
    fileprivate lazy var titleLbls: [UILabel] = [UILabel]()
    
    // MARK: 构造函数
    
    init(frame: CGRect, sytle: TCHeaderStyle, titles: [String]) {
        self.style = sytle
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: UI
extension TCHeaderView {
    
    fileprivate func setupUI() {
        addSubview(scrollView)
        
        setupTitleLabels()
    }
    
    private func setupTitleLabels() {
        let h = style.headerHeight
        var w: CGFloat = 0
        var x: CGFloat = 0
        let y: CGFloat = 0
        let count = titles.count
        for (i, title) in titles.enumerated() {
            let lbl = UILabel()
            lbl.tag = i
            lbl.text = title
            lbl.textColor = i == 0 ? style.selectColor : style.normalColor
            lbl.textAlignment = .center
            lbl.font = UIFont.systemFont(ofSize: style.titleFont)
            scrollView.addSubview(lbl)
            
            titleLbls.append(lbl)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelTap(tap:)))
            lbl.addGestureRecognizer(tap)
            lbl.isUserInteractionEnabled = true
            
            if style.isScroll {
                w = (title as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: lbl.font], context: nil).width
                x = i == 0 ? style.titleMargin * 0.5 : (titleLbls[i - 1].frame.maxX + style.titleMargin)
            } else {
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
            }
            
            lbl.frame = CGRect(x: x, y: y, width: w, height: h)
            
            if style.isScroll {
                scrollView.contentSize.width = titleLbls.last!.frame.maxX + style.titleMargin * 0.5
            }

        }
    }
}

extension TCHeaderView {
    
    @objc fileprivate func titleLabelTap(tap: UITapGestureRecognizer) {
        guard let targetLbl = tap.view as? UILabel else {
            return
        }
        
        print(targetLbl.tag)
    }
}
