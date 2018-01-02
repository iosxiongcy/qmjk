//
//  RegistViewController.swift
//  商城项目
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/8/1.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

import UIKit
import Alamofire

class RegistViewController: UIViewController {

    /// 用户名
    @IBOutlet weak var username: UITextField!
    /// 密码
    @IBOutlet weak var password: UITextField!
    /// 确认密码
    @IBOutlet weak var makesurePass: UITextField!
    /// 签名
    @IBOutlet weak var desc: UITextField!
    /// email
    @IBOutlet weak var email: UITextField!
    /// github
    @IBOutlet weak var github: UITextField!
    /// qq
    @IBOutlet weak var qq: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    /// 点击注册按钮调用
    ///
    /// - Parameter sender: 按钮
    @IBAction func regist(_ sender: UIButton) {
        
        var parameters:[String: Any] = [:];
        parameters["username"] = username.text;
        parameters["password"] = password.text;
        parameters["description"] = desc.text;
        parameters["email"] = email.text;
        parameters["github"] = github.text;
        parameters["qq"] = qq.text;
        print(parameters)
        Alamofire.request(urlString+"/regist", method: .post, parameters: parameters).responseJSON { response in


            response.result.ifSuccess {
                let dic = response.result.value as! [String : Any]
                let status = dic["status"] as! Int
                let msg = dic["message"] as! String
                
                if status == 200 {
                    
                    self.navigationController?.popViewController(animated: true)
                } else {
                    // #warning 注册失败 提示信息
                    print(msg)
                }
            }
            
            response.result.ifFailure {
                // #warning 提示注册失败
            }
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)")
//            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
