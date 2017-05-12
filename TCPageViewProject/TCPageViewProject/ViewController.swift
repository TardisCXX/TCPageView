//
//  ViewController.swift
//  TCPageViewProject
//
//  Created by tardis_cxx on 2017-5-10.
//  Copyright © 2017年 tardis_cxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor(hex: "0xcccccc")
        
        automaticallyAdjustsScrollViewInsets = false
        
        let style = TCHeaderStyle()
        style.isScroll = true
//        let titles = ["热门", "头条", "地理", "文学", "历史"]
        let titles = ["热门", "头条", "天文地理", "史前文明", "人类大科技", "暴雪游戏嘉年华", "漫威世界之平行宇宙", "美女日常"]

        
        var childControllers = [UIViewController]()
        
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = .randomColor
            childControllers.append(vc)
        }
        
        let pageRect = CGRect(x: 0, y: 64.0, width: view.bounds.width, height: view.bounds.height - 64.0)
        let pageView = TCPageView(frame: pageRect, style: style, titles: titles, childControllers: childControllers)
        pageView.backgroundColor = .randomColor
        view.addSubview(pageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

