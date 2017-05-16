//
//  TCPageViewFlowLayout.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-16.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

class TCPageViewFlowLayout: UICollectionViewFlowLayout {
    
    /// 设置列数
    var cols = 4
    /// 设置行数
    var rows = 2
    
    fileprivate lazy var cellAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    /// 页数
    fileprivate var pageCount = 0
}

extension TCPageViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        let sectionCount = collectionView.numberOfSections
        
        let itemW: CGFloat = (collectionView.bounds.width - sectionInset.left - sectionInset.right - CGFloat((cols - 1)) * minimumInteritemSpacing) / CGFloat(cols)
        let itemH: CGFloat = (collectionView.bounds.height - sectionInset.top - sectionInset.bottom - CGFloat((rows - 1)) * minimumLineSpacing) / CGFloat(rows)
        var itemY: CGFloat = 0
        var itemX: CGFloat = 0

        // 累加页数
        
        for sectionIndex in 0..<sectionCount {
            let itemCount = collectionView.numberOfItems(inSection: sectionIndex)
            
            for itemIndex in 0..<itemCount {
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // item 所在页码
                let pageIndex = itemIndex / (rows * cols)
                // item 当前页码的索引
                let pageItemIndex = itemIndex % (rows * cols)
                
                // item 所在行
                let rowIndex = pageItemIndex / cols
                // item 所在列
                let colIndex = pageItemIndex % cols
                
                itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(rowIndex)
                itemX = CGFloat((pageCount + pageIndex)) * collectionView.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(colIndex)
                
                attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                cellAttributes.append(attr)
            }
            
            // 计算当前组一共有多少页
            pageCount += (itemCount - 1) / (cols * rows) + 1
        }
    }
}

extension TCPageViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttributes
    }
}

extension TCPageViewFlowLayout {
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: CGFloat(pageCount) * collectionView!.bounds.width, height: 0)
    }
}
