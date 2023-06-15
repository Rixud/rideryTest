//
//  simpleToast.swift
//  RideryTest
//
//  Created by Luis Guerra on 15/6/23.
//

import Foundation
import UIKit

class simpleToast {
    func simpleToast(_ title:String, _ msg:String,_ root:UIViewController){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        root.present(alertController, animated: true, completion: nil)
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            alertController.dismiss(animated: false)
        }
    }
}
