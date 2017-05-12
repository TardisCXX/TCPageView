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
        
        view.backgroundColor = UIColor.white
        
        let style = TCHeaderStyle()
        let titles = ["热门", "头条", "地理", "文学", "历史"]
        var childControllers = [UIViewController]()
        
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.red
            childControllers.append(vc)
        }
        
        let pageView = TCPageView(frame: view.bounds, style: style, titles: titles, childControllers: childControllers)
        pageView.backgroundColor = UIColor.yellow
        view.addSubview(pageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

