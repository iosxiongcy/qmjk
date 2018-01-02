//
//  CYAlertView.swift
//  MyBlog
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/8/12.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

import UIKit

class CYAlertView: UIView {

    private var keyWindow: UIWindow!
    
    /// 单例
    static let shared = CYAlertView(frame: UIScreen.main.bounds)
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        initParams()
    }
    
    /// 初始化参数
    private func initParams() {
        self.keyWindow = UIApplication.shared.keyWindow;
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
