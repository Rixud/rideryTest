//
//  TFManager.swift
//  RideryTest
//
//  Created by LuisGuerra on 14/6/23.
//

import Foundation

class TFManager: ObservableObject {
    var maxDigit = 15
    @Published var text = "" {
        didSet{
            if text.count >= maxDigit && oldValue.count <= maxDigit {
                text = oldValue
            }
        }
    }
    init() {
        self.maxDigit = 15
        self.text = ""
    }
    
    init(text:String) {
        self.maxDigit = 15
        self.text = text
    }
}
