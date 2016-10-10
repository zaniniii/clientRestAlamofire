//
//  requestApi.swift
//  clientRestful
//
//  Created by Luiz Carlos Zanini on 10/10/16.
//  Copyright © 2016 Za9. All rights reserved.
//

import UIKit
import Alamofire


class requestApi: NSObject {
    
    
    //URL Base da API
    private let baseURL = "http://localhost:3000"
    
    private var header: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    private typealias JSONStandard = [String : AnyObject]
    
    
    func request(endpoint: String, method: HTTPMethod, params: Dictionary<String, AnyObject>? = nil, token: String? = nil,   completion:@escaping (_ success: Bool, _ object: AnyObject?) -> ()){
        
        if  token != nil{
            header = [
                "Accept": "application/json",
                "X-Access-Token" : token!
            ]
        }
        
        Alamofire.request(baseURL + endpoint, method:method, parameters: params, encoding: URLEncoding(destination: .methodDependent), headers: header).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                do{
                    let readableJSON = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? JSONStandard
                    completion(true, readableJSON as AnyObject!)
                }
                catch{
                    completion(true, error as AnyObject!)
                }
                
                
            case .failure(let error):
                completion(false, error as AnyObject!)
            }
        }
    }
        
}
