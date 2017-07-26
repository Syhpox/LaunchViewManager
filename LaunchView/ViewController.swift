//
//  ViewController.swift
//  LaunchView
//
//  Created by WZH on 2017/6/16.
//  Copyright © 2017年 Zhihua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    var manager: LaunchViewsManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.backgroundColor = .gray
        
        let screenRect = UIScreen.main.bounds
        let manager = LaunchViewsManager()
        let launch = LaunchImgView()
        manager.add(launch)

        for _ in 0..<5 {
            let launch0 = LaunchSubView.init(frame: screenRect)
            launch0.backgroundColor = UIColor.init(red: CGFloat(arc4random()%255) / 255.0, green: CGFloat(arc4random()%255) / 255.0, blue: CGFloat(arc4random()%255) / 255.0, alpha: 1.0)
            manager.add(launch0)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(tap:)))
            launch0.addGestureRecognizer(tap)
            launch0.isUserInteractionEnabled = true

        }
        
        
        self.view.addSubview(manager.launchView)
        
    }
    
    func tapClick(tap: UITapGestureRecognizer) {
        let tapView = tap.view as? LaunchSubView
        tapView?.nextItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

