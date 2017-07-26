//
//  LaunchView.swift
//  LaunchView
//
//  Created by WZH on 2017/6/16.
//  Copyright © 2017年 Zhihua. All rights reserved.
//

import UIKit

/// 子视图父类
class LaunchSubView: UIView {
    
    weak var manager: LaunchViewsManager?
    
    public func nextItem() {
        manager?.nextItem()
    }
    
}

class LaunchViewsManager {
    /// 最底层view
    var launchView: LaunchView!
    /// 子视图数组
    var subViews: [LaunchSubView] = []
    /// 记录当前index
    fileprivate var index: Int = 0
    /// 强行引用自己
    fileprivate var strongSelf: LaunchViewsManager?
    var completeBlc:(() -> Void)?
    
    init(frame: CGRect) {
        self.launchView = LaunchView.init(frame: frame)
        self.strongSelf = self
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    /// 下一个
    public func nextItem() {
        guard self.subViews.count != 0 else {
            return
        }
        
        if index > self.subViews.count - 1 {
            launchView.removeFromSuperview()
            if let blc = completeBlc {
                blc()
            }
            self.strongSelf = nil
            return
        }
        launchView.addSubview(self.subViews[index])
        

        if index - 1 < self.subViews.count - 1, index - 1 >= 0 {
            self.subViews[index - 1].removeFromSuperview()
        } 
        index += 1


    }
    
    /// 添加源
    public func add(_ view: LaunchSubView) {
        defer {
            if self.subViews.count == 1 {
                self.nextItem()
            }
        }
        view.manager = self
        self.subViews.append(view)
    }
    
    /// 移除源
    public func remove(_ view: LaunchSubView) {
        guard let index = self.subViews.index(of: view) else {
            return
        }
        self.subViews.remove(at: index)
    }
    
    /// 检测内存释放
    deinit {
        print("\(self) 内存释放")
    }
    
}

/// 底层视图类
public class LaunchView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
