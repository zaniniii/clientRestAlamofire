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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        api.request(endpoint: "/", method: .get) { (success, result) in
           
            if success {
                print("Sucesso")
                print(result?["api"])
            }else{
                print("Falha na comunicação com a api")
                print(result)
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

