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
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    
                    print(result?["msg"])
                    
                }else{
                    
                    print(result)
                    
                }
                
            }
            
        }
        
        
    }
}
