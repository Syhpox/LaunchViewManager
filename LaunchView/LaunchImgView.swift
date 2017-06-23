//
//  LaunchImgView.swift
//  LaunchView
//
//  Created by WZH on 2017/6/16.
//  Copyright © 2017年 Zhihua. All rights reserved.
//

import UIKit

class LaunchImgView: LaunchSubView, CAAnimationDelegate {
    
    var image: UIImageView!
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .clear
        image = UIImageView.init(frame: self.frame)
        let path = Bundle.main.path(forResource: judge(), ofType: "png")
        image.image = UIImage.init(contentsOfFile: path ?? "")
        
//        image.image = UIImage(named: judge())
        self.addSubview(image)
        
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1.0
        animation.toValue = 2.0
        
        let animation1 = CABasicAnimation()
        animation1.keyPath = "opacity"
        animation1.fromValue = 1.0
        animation1.toValue = 0.0

        let group = CAAnimationGroup()
        group.duration = 0.4
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        group.animations = [animation,animation1]
        group.delegate = self
        image.layer.add(group, forKey: nil)
        
    }
    
    /// 屏幕尺寸  获取图片名字
//    func judge() -> String {
//        switch (screenWidth, screenHeight) {
//        case (320, 480):
//            return  "640 × 960"
//        case (320, 568):
//            return  "640 × 1136"
//        case (375, 667):
//            return  "750 × 1334"
//        case (414, 736):
//            return  "1242 × 2208"
//        default:
//            return "750 × 1334"
//        }
//    }
    
    func judge() -> String {
        switch (screenWidth, screenHeight) {
        case (320, 480):
            return  "LaunchImage@2x"
        case (320, 568):
            return  "LaunchImage-700-568h@2x"
        case (375, 667):
            return  "LaunchImage-800-667h@2x"
        case (414, 736):
            return  "LaunchImage-800-Portrait-736h@3x"
        default:
            return "LaunchImage-800-667h@2x"
        }
    }

    
    // MARK: CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.nextItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
