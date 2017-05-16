//
//  TCHeaderView.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-12.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

@objc protocol TCHeaderViewDelegate: class {
    
    @objc optional func headerView(_ headerView: TCHeaderView, currentIndex: Int)
    
}

class TCHeaderView: UIView {

    // MARK: 属性
    
    /// 代理
    weak var delegate: TCHeaderViewDelegate?
    
    /// 样式
    fileprivate var style: TCHeaderStyle
    /// 标题数组
    fileprivate var titles: [String]
    /// 当前label索引
    fileprivate var currentIndex: Int = 0
    
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
    
    /// 获取普通状态的RGB值
    fileprivate lazy var normalRGB: ColorRGB = {
       return self.style.normalColor.getRGBValueFromColor()
    }()
    
    /// 获取选中状态的RGB值
    fileprivate lazy var selectRGB: ColorRGB = {
        return self.style.selectColor.getRGBValueFromColor()
    }()
    
    fileprivate lazy var deltaRGB: ColorRGB = {
        let deltaR = self.selectRGB.red - self.normalRGB.red
        let deltaG = self.selectRGB.green - self.normalRGB.green
        let deltaB = self.selectRGB.blue - self.normalRGB.blue
        
        return (deltaR, deltaG, deltaB)
    }()
    
    /// 标题标签数组
    fileprivate lazy var titleLbls: [UILabel] = [UILabel]()
    
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = self.style.bottomLineColor
        
        return view
    }()
    
    fileprivate lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = self.style.coverBackgroundColor
        view.alpha = self.style.coverAlpha
        
        return view
    }()
    
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
        
        setupBottomLine()
        
        setupCoverView()
    }
    
    private func setupCoverView() {
        if style.isShowCover == false {
            return
        }
        
        scrollView.insertSubview(coverView, at: 0)
        let firstLbl = titleLbls.first!
        var w = firstLbl.bounds.width
        let h = style.coverHeight
        var x = firstLbl.frame.origin.x
        let y = (firstLbl.frame.height - h) * 0.5
        if style.isScroll {
            x -= style.coverMargin
            w += style.coverMargin * 2
        }
        coverView.frame = CGRect(x: x, y: y, width: w, height: h)
        coverView.layer.cornerRadius = style.coverRadius
        coverView.layer.masksToBounds = true
    }
    
    private func setupBottomLine() {
        if style.isShowBottomLine == false{
            return
        }
        
        scrollView .addSubview(lineView)
        
        let x = titleLbls.first!.frame.origin.x
        let y = self.bounds.height - self.style.bottomLineHeight
        let w = titleLbls.first!.frame.width
        let h = self.style.bottomLineHeight
        
        lineView.frame = CGRect(x: x, y: y, width: w, height: h)
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
        }
        
        if style.isScaleEnabel {
            titleLbls.first?.transform = CGAffineTransform(scaleX: style.maxScale, y: style.maxScale)
        }
        
        if style.isScroll {
            scrollView.contentSize.width = titleLbls.last!.frame.maxX + style.titleMargin * 0.5
        }
    }
}

extension TCHeaderView {
    
    @objc fileprivate func titleLabelTap(tap: UITapGestureRecognizer) {
        guard let targetLbl = tap.view as? UILabel else {
            return
        }
        
        if targetLbl.tag == currentIndex {
            return
        }
        
        setTargetLabel(targetLbl)
    
        delegate?.headerView?(self, currentIndex: currentIndex)
    }
    
    /// 设置targetLabel
    fileprivate func setTargetLabel(_ targetLbl: UILabel) {
        let sourceLbl = titleLbls[currentIndex]
        sourceLbl.textColor = style.normalColor
        targetLbl.textColor = style.selectColor
        
        // 记录当前索引
        currentIndex = targetLbl.tag
        
        labelScrollToCenter(targetLbl)
        
        if style.isScaleEnabel {
            UIView.animate(withDuration: 0.25, animations: {
                sourceLbl.transform = CGAffineTransform.identity
                targetLbl.transform = CGAffineTransform(scaleX: self.style.maxScale, y: self.style.maxScale)
            })
        }
        
        if style.isShowBottomLine {
            UIView.animate(withDuration: 0.25, animations: {
                self.lineView.frame.origin.x = targetLbl.frame.origin.x
                self.lineView.frame.size.width = targetLbl.frame.width
            })
        }
        
        if style.isShowCover {
            let x = style.isScroll ? (targetLbl.frame.origin.x - style.coverMargin) : targetLbl.frame.origin.x
            let w = style.isScroll ? (targetLbl.frame.width + style.coverMargin * 2) : targetLbl.frame.width
            UIView.animate(withDuration: 0.25, animations: {
                self.coverView.frame.origin.x = x
                self.coverView.frame.size.width = w
            })
        }
    }
    
    /// 让targetLbl滚动到中间位置
    fileprivate func labelScrollToCenter(_ targetLbl: UILabel) {
        if style.isScroll == false {
            return
        }
        
        var offsetX = targetLbl.center.x - bounds.width * 0.5
        
        if offsetX < 0 {
            offsetX = 0
        }
        
        if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension TCHeaderView: TCContentViewDelegate {
    
    func contentView(_ contentView: TCContentView, visableItmeIndex: Int) {
        currentIndex = visableItmeIndex
        let lbl = titleLbls[currentIndex]
        labelScrollToCenter(lbl)
        
        print(visableItmeIndex)
    }
    
    func contentView(_ contentView: TCContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        let sourceLbl = titleLbls[sourceIndex]
        let targetLbl = titleLbls[targetIndex]
        
        let r1 = selectRGB.red - deltaRGB.red * progress
        let g1 = selectRGB.green - deltaRGB.green * progress
        let b1 = selectRGB.blue - deltaRGB.blue * progress
        sourceLbl.textColor = UIColor(r: r1, g: g1, b: b1)
        
        let r2 = normalRGB.red + deltaRGB.red * progress
        let g2 = normalRGB.green + deltaRGB.green * progress
        let b2 = normalRGB.blue + deltaRGB.blue * progress
        targetLbl.textColor = UIColor(r: r2, g: g2, b: b2)
        
        if style.isScaleEnabel {
            let deltaScale = style.maxScale - 1.0
            let scale1 = style.maxScale - deltaScale * progress
            let scale2 = 1.0 + deltaScale * progress
            sourceLbl.transform = CGAffineTransform(scaleX: scale1, y: scale1)
            targetLbl.transform = CGAffineTransform(scaleX: scale2, y: scale2)
        }
        
        if style.isShowBottomLine {
            let deltaX = targetLbl.frame.origin.x - sourceLbl.frame.origin.x
            let deltaW = targetLbl.frame.width - sourceLbl.frame.width
            lineView.frame.origin.x = sourceLbl.frame.origin.x + deltaX * progress
            lineView.frame.size.width = sourceLbl.frame.width + deltaW * progress
        }
        
        if style.isShowCover {
            let deltaX = targetLbl.frame.origin.x - sourceLbl.frame.origin.x
            let deltaW = targetLbl.frame.width - sourceLbl.frame.width
            coverView.frame.origin.x = style.isScroll ? (sourceLbl.frame.origin.x - style.coverMargin + deltaX * progress) :(sourceLbl.frame.origin.x + deltaX * progress)
            coverView.frame.size.width = style.isScroll ? (sourceLbl.frame.width + style.coverMargin * 2 + deltaW * progress) : (sourceLbl.frame.width + deltaW * progress)
        }
    }
}

// MARK: public
extension TCHeaderView {
    
    func setCurrentIndex(currentIndex: Int) {
        setTargetLabel(titleLbls[currentIndex])
    }
}
