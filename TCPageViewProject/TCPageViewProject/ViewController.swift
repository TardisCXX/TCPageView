//
//  ViewController.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-10.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

fileprivate let kUICollectionViewCellIdentifier = "UICollectionViewCell"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor(hex: "0xcccccc")
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupPageView2()
    }
    
    fileprivate func setupPageView2() {
        let style = TCHeaderStyle()
        
        let titles = ["热门", "头条", "地理", "文学"]
        
        let layout = TCPageViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.cols = 4
        layout.rows = 2

        let pageRect = CGRect(x: 0, y: 64.0, width: view.bounds.width, height: 300.0)
        let pageView = TCPageView(frame: pageRect, style: style, titles: titles, layout:layout)
        pageView.backgroundColor = .randomColor
        pageView.dataSource = self
        pageView.delegate = self
        pageView.registerCell(UICollectionViewCell.self, identifier: kUICollectionViewCellIdentifier)
        view.addSubview(pageView)
    }

    
    fileprivate func setupPageView1() {
        let style = TCHeaderStyle()
        style.isScroll = true
        //        style.isShowBottomLine = true
        //        style.isScaleEnabel = true
        style.isShowCover = true
        
        //        let titles = ["热门", "头条", "地理", "文学", "历史"]
        let titles = ["热门", "头条", "天文地理", "史前文明", "人类大科技", "暴雪游戏嘉年华", "漫威世界之平行宇宙", "美女日常"]
        
        
        var childControllers = [UIViewController]()
        
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = .randomColor
            childControllers.append(vc)
            self.addChildViewController(vc)
        }
        
        let pageRect = CGRect(x: 0, y: 64.0, width: view.bounds.width, height: view.bounds.height - 64.0)
        let pageView = TCPageView(frame: pageRect, style: style, titles: titles, childControllers: childControllers, rootController: self)
        pageView.backgroundColor = .randomColor
        view.addSubview(pageView)
    }


}

extension ViewController: TCPageViewDataSource {
    
    func numberOfSectionInPageView(_ pageView: TCPageView) -> Int {
        return 4
    }
    
    func pageView(_ pageView: TCPageView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 20
        case 1:
            return 30
        case 2:
            return 10
        case 3:
            return 15
        default:
            return 0
        }
    }
    
    func pageView(_ pageView: TCPageView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pageView.dequeueReusableCell(reuseIdentifier: kUICollectionViewCellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor
        
        return cell
    }
}

extension ViewController: TCPageViewDelegate {
    
    func pageView(_ pageView: TCPageView, didSelectedAtIndexPath indexPath: IndexPath) {
        print("section:",indexPath.section, "item:", indexPath.item)
    }
}

