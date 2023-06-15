//
//  ApiManagerRidery.swift
//  RideryTest
//
//  Created by Luis Guerra on 15/6/23.
//

import Foundation
import Alamofire

enum RateType {
    case json
    case data
    case string
    case decodable
    case none
}

class ApiManagerRidery {
    
    let url = "https://jsonplaceholder.typicode.com/todos/1"
    func callEndpoint(_ urlString:String){
        AF.request(urlString).responseJSON { response in
            print(response)
        }
    }
    
}
