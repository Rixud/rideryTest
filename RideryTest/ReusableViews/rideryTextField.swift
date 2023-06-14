//
//  rideryTextField.swift
//  RideryTest
//
//  Created by Luis Guerra on 14/6/23.
//

import Foundation
import SwiftUI

struct rideryTextField:View {
    var placeholder:String = ""
    var tittle:String = ""
    var isSecure:Bool = false
    @StateObject var textInputString: TFManager

    var body: some View {
        Text(tittle)
            .foregroundColor(Constant.mainColor)
        
        ZStack(alignment: .leading){
            if textInputString.text.isEmpty { Text(placeholder).font(.caption).foregroundColor(Constant.secondaryColor) }
            
            if isSecure {
                SecureField("", text: $textInputString.text).foregroundColor(.white)
            } else {
                TextField("", text: $textInputString.text).foregroundColor(.white)
            }
        }
        
        Divider()
            .frame(height: 1)
            .background(Constant.mainColor).padding(.bottom)
    }
    
    
}
