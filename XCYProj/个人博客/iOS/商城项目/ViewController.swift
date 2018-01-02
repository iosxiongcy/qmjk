//
//  ViewController.swift
//  商城项目
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/8/1.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var data: [String : Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    /// 登录
    @IBAction func login(_ sender: UIButton) {
        
        if (username.text?.isEmpty)! {
            // #warning "用户名不能为空!"
            debugPrint("用户名不能为空!")
            return
        }
        
//        if (password.text?.isEmpty)! {
//            // #warning "密码不能为空!"
//            debugPrint("密码不能为空!")
//            return
//        }
        
        //请求网络
        var params:[String : Any] = [:]
        params["userId"] = username.text
//        params["password"] = password.text
//        request(urlString + "/getUserInfo", method: .post, parameters: params, headers: nil).responseJSON { (response) in
//            print(response.result.value ?? "")
//        }
        request(urlString + "/getUserInfo", method: .post, parameters:params ).responseJSON { response in
            
            print(response.result.value ?? "用户信息获取失败")
            
            response.result.ifSuccess {
                let dic = response.result.value as! [String : Any]
                let status = dic["status"] as! String
                let msg = dic["errMsg"] as! String
                if status == "200" {
                    self.data = dic
                    let main = CYMainTableViewController()
                    main.data = dic
                    // #warning 登录成功 - 弹框提示
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                } else {
                    // #warning 登录失败 - 弹框提示
                    print(msg)
                }
                
            }
            
            response.result.ifFailure {
                // #warning 登录失败  需要弹框提示
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {            
            let tabVc = segue.destination as! UITabBarController
            for vc in tabVc.childViewControllers {
                if vc.isKind(of: CYMainTableViewController.self) {
                    let main = vc as! CYMainTableViewController
                    main.data = self.data!
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }

}

