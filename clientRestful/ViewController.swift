//
//  ViewController.swift
//  clientRestful
//
//  Created by Luiz Carlos Zanini on 10/10/16.
//  Copyright © 2016 Za9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let api = requestApi()
    typealias JSONStandard = [String : AnyObject]
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtResult: UILabel!
    
    @IBOutlet weak var btnLogout: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let logged = UserDefaults.standard.bool(forKey: "logged")
        
        if logged{
            
            let dados = UserDefaults.standard.value(forKey: "user") as! JSONStandard
            
            self.txtResult.text = dados["name"] as! String?
            self.btnLogout.isHidden = false
            
            
        }else{
            print("face o login")
            self.btnLogout.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func logar(_ sender: AnyObject) {
        
        
        let login = [
            "email" : self.txtEmail.text! as String,
            "password" : self.txtPassword.text! as String
        ]
        
        api.request(endpoint: "/en/login", method: .post, params: login as Dictionary<String, AnyObject>?) { (result) in
            
            
            if let error = result?["error"]{
                
                if error != nil{
                    
                    self.txtResult.text = result?["msg"] as! String?
                    return
                    
                }
                
                if let dados = result?["data"] as! JSONStandard!{
                    self.txtResult.text = dados["name"] as! String?
                    self.btnLogout.isHidden = false
                    
                    UserDefaults.standard.setValue(dados, forKey: "user")
                    UserDefaults.standard.set(true, forKey: "logged")
//                    print("\(UserDefaults.standard.value(forKey: "user")!)")
                }
                
                
            }
            
        }
        
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        UserDefaults.standard.setValue(nil, forKey: "user")
        UserDefaults.standard.set(false, forKey: "logged")
         self.txtResult.text = ""
        
        self.btnLogout.isHidden = true
    }
}
